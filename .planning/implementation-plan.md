# ZMK Config Enhancement Plan

Based on urob's zmk-config reference: https://github.com/urob/zmk-config

---

## Part 1: Fix Current Build Failures

### Actual Error from GitHub Actions (mac branch)

```
devicetree error: /home/runner/work/_temp/tests/config/base.keymap:13 (column 1):
parse error: expected '/' or label reference (&foo)
```

The preprocessed output shows `ZMK_HOLD_TAP` macro NOT being expanded:
```
ZMK_HOLD_TAP(hml, bindings = <&kp>, <&kp>; flavor = "balanced";
             tapping-term-ms = <280>; quick-tap-ms = <QUICK_TAP_MS>; ...)
```

### Root Causes

1. **Missing `helper.h` include** - `base.keymap` uses `ZMK_HOLD_TAP` macro from zmk-helpers but the header file is never included. The macro appears verbatim instead of being expanded.

2. **Undefined `QUICK_TAP_MS`** - Also appears verbatim in preprocessed output (line 9 of base.keymap)

3. **Undefined layer constants in `mouse.dtsi`** - References `NAV` and `FN` layers (lines 24-29, 45-51) but these aren't defined

4. **`mouse.dtsi` never included** - The file exists but isn't included in `corne.keymap`

### Fixes Required

**Option A: Quick fix (minimal changes)**
```c
// config/corne.keymap - Add BEFORE #include "base.keymap":
#include "zmk-helpers/helper.h"

#define QUICK_TAP_MS 175
```

**Option B: Proper modular structure (recommended)**
```c
// config/corne.keymap - Reorganize top section:
#include <behaviors.dtsi>
#include <dt-bindings/zmk/keys.h>
#include <dt-bindings/zmk/bt.h>
#include <dt-bindings/zmk/backlight.h>

// zmk-helpers (MUST come before using any ZMK_* macros)
#include "zmk-helpers/helper.h"
#include "zmk-helpers/key-labels/36.h"

// Timing constants (MUST be defined before base.keymap)
#define QUICK_TAP_MS 175
#define TAPPING_TERM_MS 280

// Layer indices (needed for mouse.dtsi)
#define BASE 0
#define LOWER 1
#define RAISE 2
#define BT 3
#define NAV 4
#define FN 2  // or whatever layer you want for precision mouse

// Feature modules
#include "base.keymap"
// #include "mouse.dtsi"  // Uncomment when ready
```

**For mouse.dtsi** - Either:
- Replace `NAV` and `FN` with numeric layer indices directly
- Or ensure they're defined as `#define` constants before the include

---

## Part 2: Local Nix Build Setup

### Prerequisites

1. **Install Nix** (with flakes enabled):
   ```bash
   # Recommended: Determinate Systems installer (flakes enabled by default)
   curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install

   # Alternative: Official installer (requires manual flake enablement)
   sh <(curl -L https://nixos.org/nix/install) --daemon
   ```

   **Note**: Nix is NOT available via Homebrew. You must use one of the installers above.

2. **Enable Flakes** (only needed with official installer):
   ```bash
   # Create config directory if needed
   mkdir -p ~/.config/nix

   # Add to ~/.config/nix/nix.conf:
   echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
   ```

3. **Install direnv** (recommended for auto-activation):
   ```bash
   # Using Homebrew
   brew install direnv

   # Add to ~/.zshrc (or ~/.bashrc):
   eval "$(direnv hook zsh)"
   ```

4. **Install nix-direnv** (makes direnv + nix faster):
   ```bash
   # After nix is installed:
   nix profile install nixpkgs#nix-direnv

   # Add to ~/.config/direnv/direnvrc:
   mkdir -p ~/.config/direnv
   echo 'source $HOME/.nix-profile/share/nix-direnv/direnvrc' >> ~/.config/direnv/direnvrc
   ```

### Workspace Setup

1. **Clone urob's workspace structure** or create your own:
   ```bash
   # Option A: Use urob's as template
   git clone https://github.com/urob/zmk-config zmk-workspace
   cd zmk-workspace

   # Option B: Set up from scratch
   mkdir zmk-workspace && cd zmk-workspace
   # Copy your config folder here
   # Create flake.nix (see below)
   ```

2. **Initialize West workspace**:
   ```bash
   west init -l config
   west update
   west zephyr-export
   ```

3. **Create `flake.nix`** (if not using urob's):
   ```nix
   {
     inputs = {
       nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
       zephyr-nix.url = "github:zephyrproject-rtos/zephyr-nix";
     };

     outputs = { self, nixpkgs, zephyr-nix, ... }:
       let
         systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
         forAllSystems = nixpkgs.lib.genAttrs systems;
       in {
         devShells = forAllSystems (system:
           let
             pkgs = nixpkgs.legacyPackages.${system};
             zephyr = zephyr-nix.packages.${system};
           in {
             default = pkgs.mkShellNoCC {
               packages = [
                 zephyr.pythonEnv
                 (zephyr.sdk.override { targets = [ "arm-zephyr-eabi" ]; })
                 pkgs.cmake
                 pkgs.dtc
                 pkgs.ninja
                 pkgs.just  # Optional task runner
               ];
             };
           }
         );
       };
   }
   ```

4. **Create `.envrc`**:
   ```bash
   use flake
   ```

5. **Allow direnv**:
   ```bash
   direnv allow
   ```

### Build Commands

With the nix environment active:

```bash
# Build all targets
west build -s zmk/app -d build/left -b nice_nano_v2 -- \
  -DSHIELD="corne_left nice_view_adapter nice_view" \
  -DZMK_CONFIG="${PWD}/config"

# Or with just (if using urob's justfile)
just build all
just build left
just build right

# Generate keymap visualization
just draw
```

### Alternative: Use urob's zmk-actions (No Local Nix)

Your current GitHub Actions workflow already uses `urob/zmk-actions` which handles everything. You don't strictly need local nix builds unless you want faster iteration.

---

## Part 3: Modular Configuration Structure

### Current vs Target Structure

```
Current:                          Target (urob-style):
config/                           config/
├── corne.keymap (monolithic)     ├── base.keymap (HRM + core behaviors)
├── base.keymap (HRM only)        ├── combos.dtsi
├── mouse.dtsi (unused)           ├── leader.dtsi
├── west.yml                      ├── mouse.dtsi
└── corne.conf                    ├── corne.keymap (minimal, includes all)
                                  ├── west.yml
                                  └── corne.conf
```

### Refactoring Steps

1. **Create `config/combos.dtsi`** - Move all combo definitions here
2. **Create `config/leader.dtsi`** - For leader key sequences (if desired)
3. **Update `config/base.keymap`** - Add shared behaviors, constants
4. **Refactor `config/corne.keymap`**:
   - Add includes for all modules
   - Define layer number constants
   - Keep only the keymap itself

### Example Modular corne.keymap Structure

```c
#include <behaviors.dtsi>
#include <dt-bindings/zmk/keys.h>
#include <dt-bindings/zmk/bt.h>

// zmk-helpers
#include "zmk-helpers/helper.h"
#include "zmk-helpers/key-labels/36.h"

// Layer definitions (numeric constants)
#define BASE 0
#define LOWER 1
#define RAISE 2
#define BT 3
#define NAV 4
#define MOUSE 5

// Timing constants
#define QUICK_TAP_MS 175
#define TAPPING_TERM_MS 280
#define COMBO_TERM_FAST 18
#define COMBO_TERM_SLOW 30

// Feature modules
#include "base.keymap"    // HRM definitions
#include "combos.dtsi"    // Combo definitions
#include "mouse.dtsi"     // Mouse emulation

/ {
    keymap {
        compatible = "zmk,keymap";
        // Layer definitions here...
    };
};
```

---

## Part 4: Features to Implement

### 4.1 Enhanced Combos System

**What it provides**: Access symbols without moving to layers

```c
// config/combos.dtsi
#define COMBO_TERM_FAST 18
#define COMBO_TERM_SLOW 30
#define COMBO_IDLE_FAST 150
#define COMBO_IDLE_SLOW 50

// Horizontal combos - left hand
ZMK_COMBO(esc,    &kp ESC,      LT3 LT2,      BASE, COMBO_TERM_FAST, COMBO_IDLE_FAST)
ZMK_COMBO(tab,    &kp TAB,      LM3 LM2,      BASE, COMBO_TERM_FAST, COMBO_IDLE_FAST)

// Horizontal combos - right hand
ZMK_COMBO(bspc,   &kp BSPC,     RT2 RT3,      BASE, COMBO_TERM_FAST, COMBO_IDLE_FAST)
ZMK_COMBO(del,    &kp DEL,      RT1 RT2,      BASE, COMBO_TERM_FAST, COMBO_IDLE_FAST)

// Vertical combos for symbols
ZMK_COMBO(at,     &kp AT,       LT3 LM3,      BASE, COMBO_TERM_SLOW, COMBO_IDLE_SLOW)
ZMK_COMBO(hash,   &kp HASH,     LT2 LM2,      BASE, COMBO_TERM_SLOW, COMBO_IDLE_SLOW)
```

### 4.2 Smart Repeat/Shift Key

**What it provides**: Context-aware thumb key behavior
- After alpha: repeats last key
- After non-alpha: sticky shift
- Hold: standard shift
- Double-tap: caps word

```c
// Requires zmk-adaptive-key module
ZMK_ADAPTIVE_KEY(
    smart_shft,
    bindings = <&sk LSHFT>;  // Default: sticky shift
    repeat {
        trigger-keys = <A B C D E F G H I J K L M N O P Q R S T U V W X Y Z>;
        bindings = <&key_repeat>;
    };
)
```

### 4.3 Mouse Layer with Auto-Toggle

**What it provides**: Combo-activated mouse control that auto-deactivates

```c
// Uses zmk-auto-layer module
/ {
    behaviors {
        ZMK_AUTO_LAYER(mouse_layer,
            layers = <MOUSE>;
            continue-keys = <MOVE_UP MOVE_DOWN MOVE_LEFT MOVE_RIGHT
                            SCRL_UP SCRL_DOWN MB1 MB2>;
        )
    };

    combos {
        // W+P activates mouse layer
        ZMK_COMBO(mouse, &mouse_layer, LT1 RT4, BASE, 50, 150)
    };
};

// Mouse layer keymap
mouse_layer {
    bindings = <
        ___  ___  ___        U_MS_U     ___        ___          ___  ___       ___       ___       ___  ___
        ___  ___  U_MS_L     U_MS_D     U_MS_R     ___          ___  &mkp MB1  &mkp MB2  &mkp MB3  ___  ___
        ___  ___  U_WH_L     U_WH_D     U_WH_R     ___          ___  ___       ___       ___       ___  ___
                             ___        ___        ___          ___  ___       ___
    >;
};
```

### 4.4 Tri-State (Swapper) for Alt-Tab

**What it provides**: Hold key, tap to cycle windows

```c
// Requires zmk-tri-state module
ZMK_TRI_STATE(swapper,
    bindings = <&kt LALT>, <&kp TAB>, <&kt LALT>;
    ignored-key-positions = <LT2>;  // Allow shift modifier
)
```

### 4.5 Leader Key Sequences

**What it provides**: Vim-style key sequences for complex macros

```c
// Requires zmk-leader-key module
// config/leader.dtsi
ZMK_LEADER(my_leader,
    bindings = <&kp SPACE>;  // Trigger key

    // Arrow key shortcuts: leader + h/j/k/l
    ZMK_LEADER_SEQ(ldr_left,  &kp LEFT,  H)
    ZMK_LEADER_SEQ(ldr_down,  &kp DOWN,  J)
    ZMK_LEADER_SEQ(ldr_up,    &kp UP,    K)
    ZMK_LEADER_SEQ(ldr_right, &kp RIGHT, L)

    // Git shortcuts: leader + g + c (commit), p (push), etc.
    ZMK_LEADER_SEQ(git_commit, &macro_git_commit, G C)
    ZMK_LEADER_SEQ(git_push,   &macro_git_push,   G P)
)
```

### 4.6 Caps Word

**What it provides**: Auto-disable caps after space/punctuation

```c
&caps_word {
    continue-list = <UNDERSCORE MINUS BACKSPACE DELETE>;
};

// In keymap, bind to key or combo
ZMK_COMBO(capsword, &caps_word, LM1 RM1, BASE, 50, 150)
```

### 4.7 Unicode Support

**What it provides**: Direct unicode character input

```c
// Requires zmk-unicode module
ZMK_UNICODE_SINGLE(euro,  N2 N0 A C)     // €
ZMK_UNICODE_SINGLE(pound, N0 N0 A N3)    // £
ZMK_UNICODE_PAIR(de_ae, N0 N0 E N4, N0 N0 C N4)  // ä/Ä
```

---

## Part 5: Implementation Priority

### Phase 1: Fix Build (Required First)
1. Add `#include "zmk-helpers/helper.h"` to corne.keymap
2. Define `QUICK_TAP_MS` constant
3. Define layer number constants (NAV, FN, etc.)
4. Fix or remove mouse.dtsi includes
5. Verify GitHub Actions builds pass

### Phase 2: Modularize Structure
1. Extract combos to `combos.dtsi`
2. Move constants to top of corne.keymap
3. Clean up base.keymap
4. Test build

### Phase 3: Add Core Features
1. Expand combos for symbols (urob-style)
2. Add caps word
3. Implement alt-tab swapper

### Phase 4: Advanced Features
1. Mouse layer with auto-toggle
2. Smart repeat/shift key
3. Leader key sequences

### Phase 5: Local Nix Setup (Optional)
1. Install Nix on your Mac
2. Set up workspace structure
3. Create flake.nix
4. Configure direnv

---

## Resources

- [urob's zmk-config](https://github.com/urob/zmk-config)
- [zmk-helpers documentation](https://github.com/urob/zmk-helpers)
- [ZMK documentation](https://zmk.dev/docs)
- [Nix installation](https://nixos.org/download.html)
- [Determinate Nix installer](https://determinate.systems/posts/determinate-nix-installer/) (recommended for macOS)

---

## Notes

- Your current `west.yml` already includes all the zmk modules you need (zmk-helpers, zmk-auto-layer, etc.)
- The main issue is just proper includes and constant definitions
- GitHub Actions via urob/zmk-actions works well; local nix is optional for faster iteration

---

## Branch Status

| Branch | build.yml (zmkfirmware) | build-nix.yml (urob) | Notes |
|--------|------------------------|---------------------|-------|
| `mac-pre` | Success | Success | Working config |
| `mac` | N/A (disabled) | **Failing** | Missing helper.h include |
| `main` | N/A | N/A | Base branch |

The `mac` branch introduced `base.keymap` with `ZMK_HOLD_TAP` macros but forgot to include `helper.h` first. The `mac-pre` branch works because it doesn't use those macros.
