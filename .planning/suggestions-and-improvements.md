# Suggestions and Improvements for Your Setup

Based on your current keymap analysis and the issues you mentioned.

---

## Current Pain Points (You Mentioned)

1. **Right thumb ALT is useless** - You have Alt on home row (D/K)
2. **Layers are sticky** - `mom_or_to` with tap=toggle gets you stuck
3. **Symbols layer unclear** - Hard to remember what's where

---

## Issue #1: Right Thumb Alt Key

### The Problem
```
Current thumb cluster:
│ TAB  LWR  SPC │   │ BSP  RSE  ALT │
```

With Home Row Mods:
- Left Alt = D key (hold)
- Right Alt = K key (hold)

The dedicated ALT thumb key is 100% redundant.

### Recommended Solution: Smart Shift / Magic Key

Replace `&kp RIGHT_ALT` with `&magic_key`:

```c
// FROM:
&bkspc_del  &mom_or_to 2 2  &kp RIGHT_ALT

// TO:
&bkspc_del  &mom_or_to 2 2  &magic_key
```

See `features/02-smart-shift-repeat.md` for full implementation.

**Benefits:**
- Tap after letter → Repeat (faster double letters)
- Tap after space → Sticky shift (one capital)
- Hold → Standard shift
- Double-tap → Caps Word

### Alternative Uses for This Key

If you don't want Smart Shift, other options:

| Replacement | Why |
|-------------|-----|
| `&key_repeat` | Just the repeat function |
| `&caps_word` | Quick access to Caps Word |
| `&swapper` | Alt-Tab without holding |
| `&leader` | Leader key for sequences |
| `&to MOUSE` | Quick mouse layer access |

---

## Issue #2: Sticky Layers (Getting Stuck)

### The Problem

Your current layer keys use `mom_or_to`:
```c
mom_or_to: mom_or_to {
    compatible = "zmk,behavior-hold-tap";
    bindings = <&mo>, <&to>;  // hold = momentary, TAP = TOGGLE
    tapping-term-ms = <200>;
};

// Usage:
&mom_or_to 1 1  // Tap = GO TO layer 1 (stuck!)
&mom_or_to 2 2  // Tap = GO TO layer 2 (stuck!)
```

When you accidentally tap instead of hold, you're stuck on that layer until you manually switch back.

### Recommended Solution A: Momentary Only (Simple)

Just use `&mo` for layer access:

```c
// FROM:
&kp TAB  &mom_or_to 1 1  &kp SPACE    &bkspc_del  &mom_or_to 2 2  &kp RIGHT_ALT

// TO:
&kp TAB  &mo 1           &kp SPACE    &bkspc_del  &mo 2           &magic_key
```

**Behavior:**
- Hold = Layer active
- Release = Back to base
- Never get stuck

**Downside:** Can't toggle to a layer for extended work.

### Recommended Solution B: Layer-Tap with Balanced Timing

If you want tap=something else:

```c
// Layer-tap: hold = layer, tap = key
lower_ht: lower_hold_tap {
    compatible = "zmk,behavior-hold-tap";
    label = "LOWER_HT";
    #binding-cells = <2>;
    flavor = "balanced";
    tapping-term-ms = <200>;
    quick-tap-ms = <175>;
    bindings = <&mo>, <&kp>;
};

// Usage: hold = Lower, tap = Escape (or whatever)
&lower_ht 1 ESC
```

### Recommended Solution C: Double-Tap to Toggle

If you sometimes WANT to toggle:

```c
layer_td: layer_tap_dance {
    compatible = "zmk,behavior-tap-dance";
    label = "LAYER_TD";
    #binding-cells = <0>;
    tapping-term-ms = <200>;
    bindings = <&mo 1>, <&to 1>;  // Tap = momentary, Double-tap = toggle
};
```

**Behavior:**
- Single tap + hold = Momentary layer
- Double tap = Toggle (intentional)
- Single tap + release = Nothing (no accidental toggle)

### Recommended Solution D: Tri-Layer (Urob Style)

Hold both layer keys = Third layer:

```c
/ {
    conditional_layers {
        compatible = "zmk,conditional-layers";
        tri_layer {
            if-layers = <1 2>;  // If Lower AND Raise
            then-layer = <3>;   // Activate BT layer
        };
    };
};

// Then use simple &mo:
&mo 1  // Lower
&mo 2  // Raise
// Hold both = BT layer (no dedicated key needed)
```

### My Recommendation

**Use Solution A (simple `&mo`)** with these changes:

1. Remove `mom_or_to` behavior entirely
2. Use `&mo 1` and `&mo 2` for layer access
3. Add tri-layer for BT access
4. Use your existing combo for BT as backup

```c
// Updated thumb cluster:
&kp TAB  &mo 1  &kp SPACE    &bkspc_del  &mo 2  &magic_key
```

---

## Issue #3: Unclear Symbols Layer

### Current Lower Layer Analysis

```
╭─────────────────────────────╮ ╭─────────────────────────────╮
│  -   1   2   3   4   5      │ │  6   7   8   9   0   -      │
│  -   -  =   [   ]   \       │ │  _   +   {   }   |   -      │
│  -  ←W ←T  ⌘Z  T→  W→       │ │  -   -   (   )   -   -      │
╰──────────╮ -  ▼0  ___       │ │ ___ ▼2   - ╭─────────────────╯
           ╰──────────────────╯ ╰────────────╯
```

**Issues:**
1. Symbols are split awkwardly (- = on left, _ + on right)
2. Home row has navigation shortcuts mixed with symbols
3. Bottom row has more navigation (←W = word left, etc.)
4. Hard to build muscle memory

### Suggested Reorganization

**Option A: Paired Symbols (Match Opening/Closing)**

```
╭─────────────────────────────╮ ╭─────────────────────────────╮
│  `   1   2   3   4   5      │ │  6   7   8   9   0   -      │
│  ~   !   @   #   $   %      │ │  ^   &   *   (   )   =      │
│  -   [   ]   {   }   \      │ │  |   -   _   +   /   _      │
╰──────────╮TAB  ▼0  SPC      │ │BSP  ▼2  ___ ╭────────────────╯
           ╰──────────────────╯ ╰─────────────╯
```

**Logic:**
- Row 1: Numbers (unchanged)
- Row 2: Shift+numbers (!, @, #, etc.)
- Row 3: Brackets and operators

**Option B: Numpad + Symbols**

```
╭─────────────────────────────╮ ╭─────────────────────────────╮
│  `   !   @   #   $   %      │ │  ^   7   8   9   /   =      │
│  ~   [   ]   {   }   \      │ │  &   4   5   6   *   +      │
│  -   (   )   <   >   |      │ │  _   1   2   3   -   _      │
╰──────────╮TAB  ▼0  SPC      │ │BSP  0   .  ╭─────────────────╯
           ╰──────────────────╯ ╰────────────╯
```

**Logic:**
- Left hand: All symbols
- Right hand: Numpad layout
- Natural number entry

**Option C: Keep Current, Add Visual Map**

Make a reference card and practice:

```
YOUR LOWER LAYER CHEAT SHEET:
═══════════════════════════════

LEFT HAND (Symbols):              RIGHT HAND (Shifted Symbols):
┌─────────────────────────┐       ┌─────────────────────────┐
│     1   2   3   4   5   │       │  6   7   8   9   0      │
│     -   =   [   ]   \   │       │  _   +   {   }   |      │
│ nav nav nav nav nav     │       │          (   )          │
└─────────────────────────┘       └─────────────────────────┘

HOME ROW LOGIC:
-  =  [  ]  \   are BASE
_  +  {  }  |   are SHIFTED (right side mirrors left)
```

### My Recommendation

1. **Move navigation OFF the symbols layer**
   - Put nav shortcuts on Raise layer (where arrows are)
   - Keep Lower pure for symbols/numbers

2. **Use combos for frequent symbols**
   - See `features/01-combos.md`
   - Reduce reliance on layer switching

3. **Create a visual reference**
   - Print out layer maps
   - Practice until muscle memory develops

---

## Additional Ergonomic Suggestions

### 1. Consider Removing/Changing Outer Column Keys

Your outer columns have:
```
Left: GRAVE, ESC, shift_win
Right: caps_ptsc, SQT, ENTER
```

Some could be combos instead:
- GRAVE → Combo or layer
- ESC → W+E combo (very common)
- ENTER → K+L combo or thumb key

This would let you use a more compact posture.

### 2. Hyper Key Usage

You have Hyper (Shift+Ctrl+Alt+GUI) on G and H:
```c
&hml LS(LA(LC(LEFT_GUI))) G
&hmr RS(RA(RC(RIGHT_GUI))) H
```

**Question:** Do you actually use this?

If not, consider:
- Regular key (no HRM on G/H)
- Different modifier
- Macro trigger

### 3. Thumb Key Optimization

Current:
```
│ TAB  LWR  SPC │   │ BSP  RSE  ALT │
```

Suggested:
```
│ TAB  LWR  SPC │   │ BSP  RSE  MAGIC │
```

Or more aggressive:
```
│ ESC  LWR  SPC │   │ BSP  RSE  MAGIC │
           └── TAB moved to combo (S+D)
```

### 4. Backspace/Delete Position

Your `bkspc_del` is great:
- Tap = Backspace
- Shift+Tap = Delete

Consider also adding:
- Ctrl+Backspace = Delete word (could be combo)
- On layer: Backspace in same position for muscle memory

---

## Quick Wins (Easy Changes)

### 1. Fix the Build (Required)
```c
// Add to corne.keymap BEFORE #include "base.keymap":
#include "zmk-helpers/helper.h"
#define QUICK_TAP_MS 175
```

### 2. Replace Right Alt with Magic Key
```c
// In Main layer:
&bkspc_del  &mo 2  &magic_key  // Was: &kp RIGHT_ALT
```

### 3. Use Simple Momentary Layers
```c
// Replace mom_or_to with mo:
&mo 1  // Was: &mom_or_to 1 1
&mo 2  // Was: &mom_or_to 2 2
```

### 4. Add Caps Word Combo
```c
combo_caps_word {
    timeout-ms = <50>;
    key-positions = <16 19>;  // F + J
    bindings = <&caps_word>;
    layers = <0>;
};
```

### 5. Configure Caps Word
```c
&caps_word {
    continue-list = <UNDERSCORE MINUS BACKSPACE DELETE>;
};
```

---

## Implementation Order

### Phase 1: Fix and Stabilize (Do First)
1. Fix build errors (helper.h, QUICK_TAP_MS)
2. Replace `mom_or_to` with `&mo`
3. Test builds pass

### Phase 2: Quick Ergonomic Wins
1. Replace right Alt with magic_key or simple `&sk LSHFT`
2. Add Caps Word combo
3. Replace caps_ptsc with caps_word_ptsc

### Phase 3: Combos for Symbols
1. Add 5-10 most-used symbol combos
2. Practice for 1 week
3. Adjust timing if needed

### Phase 4: Layer Reorganization
1. Decide on symbols layer approach
2. Move navigation to dedicated area
3. Update muscle memory

### Phase 5: Advanced Features
1. Consider tri-state swapper
2. Evaluate mouse layer needs
3. Add leader key if useful

---

## Summary of Recommended Changes

| Current | Recommended | Why |
|---------|-------------|-----|
| `&kp RIGHT_ALT` | `&magic_key` | Redundant with HRM |
| `&mom_or_to 1 1` | `&mo 1` | Prevents getting stuck |
| `&mom_or_to 2 2` | `&mo 2` | Prevents getting stuck |
| `&kp CAPS` (in tap-dance) | `&caps_word` | Smarter capitalization |
| No combos for symbols | Add 10-15 combos | Faster access |
| No Caps Word combo | Add F+J combo | Quick activation |

---

## Your Updated Main Layer (Proposed)

```c
Main {
    bindings = <
//╭────────┬────────┬────────┬────────┬────────┬────────╮ ╭────────┬────────┬────────┬────────┬────────┬────────╮
   &kp GRAVE &kp Q   &kp W    &kp E    &kp R    &kp T      &kp Y    &kp U    &kp I    &kp O   &kp SEMI &caps_word_ptsc
//├────────┼────────┼────────┼────────┼────────┼────────┤ ├────────┼────────┼────────┼────────┼────────┼────────┤
   &kp ESC  &hml LSHFT A &hml LCTRL S &hml LALT D &hml LGUI F &hml HYPER G   &hmr HYPER H &hmr RGUI J &hmr RALT K &hmr RCTRL L &hmr RSHFT P &kp SQT
//├────────┼────────┼────────┼────────┼────────┼────────┤ ├────────┼────────┼────────┼────────┼────────┼────────┤
   &shift_win &kp Z  &kp X    &kp C    &kp V    &kp B      &kp N    &kp M   &kp COMMA &kp DOT &kp FSLH &kp ENTER
//╰────────┴────────┴────────┼────────┼────────┼────────┤ ├────────┼────────┼────────┼────────┴────────┴────────╯
                              &kp TAB  &mo 1    &kp SPACE  &bkspc_del &mo 2  &magic_key
//                           ╰────────┴────────┴────────╯ ╰────────┴────────┴────────╯
    >;
    label = "Main";
};
```

**Changes from your current:**
1. `&mom_or_to 1 1` → `&mo 1`
2. `&mom_or_to 2 2` → `&mo 2`
3. `&kp RIGHT_ALT` → `&magic_key`
4. `&caps_ptsc` → `&caps_word_ptsc`
