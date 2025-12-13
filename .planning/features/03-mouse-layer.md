# Feature: Mouse Emulation Layer

## What Is It?

A dedicated layer that turns your keyboard into a mouse:
- WASD-style or arrow-style movement
- Scroll wheel emulation
- Left/middle/right click buttons
- Optional: Auto-deactivation when you stop using mouse keys

## Why Use It?

1. **Never leave the keyboard** - Quick cursor adjustments without reaching for mouse
2. **Ergonomic** - Reduce shoulder strain from mouse reaching
3. **Precision control** - Adjustable speed for fine work
4. **Portable** - Works without external mouse

## When Is It Useful?

- Clicking a button in a dialog box
- Scrolling through a document while reading
- Quick UI interactions between typing sessions
- Situations where mouse access is limited (travel, standing desk)

**When it's NOT ideal:**
- Extended mousing sessions (use real mouse)
- Gaming or graphics work (precision needed)
- Rapid multi-directional movement

---

## How Mouse Emulation Works in ZMK

ZMK's pointing device support provides:
- `&mmv` - Mouse movement
- `&msc` - Mouse scroll
- `&mkp` - Mouse button press

### Movement Codes
```c
MOVE_UP, MOVE_DOWN, MOVE_LEFT, MOVE_RIGHT
SCRL_UP, SCRL_DOWN, SCRL_LEFT, SCRL_RIGHT
MB1 (left), MB2 (right), MB3 (middle), MB4, MB5
```

---

## Your Current mouse.dtsi Analysis

You already have a `mouse.dtsi` file with:
- Movement and scroll speed settings
- Acceleration curves
- Layer-based speed adjustments (NAV = fast, FN = precision)
- Macro definitions for movement keys

**Issues to fix:**
- References `NAV` and `FN` layers but these aren't defined
- File is never included in your keymap

---

## Implementation for Your Setup

### Option 1: Manual Layer Toggle (Simple)

Add a mouse layer activated by a combo or key.

#### Step 1: Define layer constant

In `corne.keymap`, add before includes:
```c
#define BASE 0
#define LOWER 1
#define RAISE 2
#define BT 3
#define NAV 4
#define MOUSE 5  // New mouse layer
```

#### Step 2: Fix mouse.dtsi

Update the layer references:
```c
// config/mouse.dtsi
// Settings tuned for your display resolution
#define ZMK_POINTING_DEFAULT_MOVE_VAL 600
#define ZMK_POINTING_DEFAULT_SCRL_VAL 20

#include <dt-bindings/zmk/pointing.h>

&mmv {
    acceleration-exponent = <1>;
    time-to-max-speed-ms = <500>;
    delay-ms = <0>;
};

&msc {
    acceleration-exponent = <0>;
    time-to-max-speed-ms = <300>;
    delay-ms = <0>;
};

// Convenience macros
#define U_MS_U &mmv MOVE_UP
#define U_MS_D &mmv MOVE_DOWN
#define U_MS_L &mmv MOVE_LEFT
#define U_MS_R &mmv MOVE_RIGHT
#define U_WH_U &msc SCRL_UP
#define U_WH_D &msc SCRL_DOWN
#define U_WH_L &msc SCRL_LEFT
#define U_WH_R &msc SCRL_RIGHT
```

#### Step 3: Add Mouse Layer to Keymap

```c
// Include mouse.dtsi after layer definitions
#include "mouse.dtsi"

// In your keymap, add after Nav layer:
Mouse {
    label = "Mouse";
    bindings = <
//╭────────┬────────┬────────┬────────┬────────┬────────╮ ╭────────┬────────┬────────┬────────┬────────┬────────╮
   &to BASE &none    &none    U_MS_U   &none    &none      &none    U_WH_U   &none    &none    &none    &none
//├────────┼────────┼────────┼────────┼────────┼────────┤ ├────────┼────────┼────────┼────────┼────────┼────────┤
   &none    &none    U_MS_L   U_MS_D   U_MS_R   &none      U_WH_L   U_WH_D   U_WH_R   &none    &none    &none
//├────────┼────────┼────────┼────────┼────────┼────────┤ ├────────┼────────┼────────┼────────┼────────┼────────┤
   &none    &none    &none    &none    &none    &none      &none    &mkp MB1 &mkp MB3 &mkp MB2 &none    &none
//╰────────┴────────┴────────┼────────┼────────┼────────┤ ├────────┼────────┼────────┼────────┴────────┴────────╯
                              &to BASE &mkp MB1 &mkp MB2   &mkp MB1 &mkp MB2 &to BASE
//                           ╰────────┴────────┴────────╯ ╰────────┴────────┴────────╯
    >;
};
```

#### Step 4: Add Combo to Activate

```c
// In your combos section:
combo_mouse {
    timeout-ms = <50>;
    require-prior-idle-ms = <150>;
    key-positions = <2 9>;  // W + O (cross-hand combo)
    bindings = <&to MOUSE>;
    layers = <BASE>;
};
```

---

### Option 2: Auto-Toggle Layer (Advanced)

The layer automatically deactivates when you press a non-mouse key.

#### Requires zmk-auto-layer module

You have this in your `west.yml`:
```yaml
- name: zmk-auto-layer
  path: modules/zmk/auto-layer
```

#### Implementation

```c
/ {
    behaviors {
        // Auto-layer behavior for mouse
        mouse_tog: mouse_toggle {
            compatible = "zmk,behavior-auto-layer";
            label = "MOUSE_TOGGLE";
            #binding-cells = <0>;
            toggle-layers = <MOUSE>;
            continue-keys = <
                // Mouse movement
                MOVE_UP MOVE_DOWN MOVE_LEFT MOVE_RIGHT
                // Scroll
                SCRL_UP SCRL_DOWN SCRL_LEFT SCRL_RIGHT
                // Buttons
                MB1 MB2 MB3
            >;
        };
    };

    combos {
        compatible = "zmk,combos";

        combo_mouse {
            timeout-ms = <50>;
            require-prior-idle-ms = <150>;
            key-positions = <2 9>;  // W + O
            bindings = <&mouse_tog>;
            layers = <BASE>;
        };
    };
};
```

With auto-toggle:
- Press W+O → Enter mouse layer
- Use mouse keys → Stay in mouse layer
- Press any other key → Automatically return to base layer

---

## Layout Comparison

### WASD Style (Left Hand Movement)
```
╭────────────────────────────╮
│         [UP]               │
│  [LEFT] [DOWN] [RIGHT]     │
│                            │
│     Scrolls on right hand  │
│     Clicks on thumbs       │
╰────────────────────────────╯
```

Good for: Gamers, left-hand dominant mousing

### HJKL Style (Right Hand Movement)
```
╭────────────────────────────╮
│                            │
│     [LEFT][DOWN][UP][RIGHT]│
│                            │
│     Scrolls on left hand   │
│     Clicks on thumbs       │
╰────────────────────────────╯
```

Good for: Vim users, right-hand dominant

### Suggested Layout (WASD + Right Scroll)

```
Mouse Layer:
╭─────────────────────────────╮ ╭─────────────────────────────╮
│ BASE  -   -   UP   -   -    │ │  -  SCRL↑  -   -   -   -    │
│  -    -  LFT DWN RGT  -     │ │ ←  SCRL↓  →   -   -   -     │
│  -    -   -   -   -   -     │ │  -  LMB  MMB RMB  -   -     │
╰──────────╮BASE LMB RMB      │ │ LMB RMB BASE╭────────────────╯
           ╰──────────────────╯ ╰─────────────╯

Keys:
- UP/DOWN/LEFT/RIGHT = Cursor movement
- SCRL↑/↓/←/→ = Scroll wheel
- LMB/MMB/RMB = Mouse buttons
- BASE = Return to base layer
```

---

## Speed Tuning

### For General Use
```c
#define ZMK_POINTING_DEFAULT_MOVE_VAL 600  // Higher = faster
#define ZMK_POINTING_DEFAULT_SCRL_VAL 20   // Higher = faster scroll
```

### For High-DPI Displays (4K)
```c
#define ZMK_POINTING_DEFAULT_MOVE_VAL 800
#define ZMK_POINTING_DEFAULT_SCRL_VAL 25
```

### For Precision Work
```c
#define ZMK_POINTING_DEFAULT_MOVE_VAL 400
#define ZMK_POINTING_DEFAULT_SCRL_VAL 15
```

### Acceleration Settings
```c
&mmv {
    acceleration-exponent = <1>;    // 0=linear, 1=slight accel, 2=strong accel
    time-to-max-speed-ms = <500>;   // How long to reach max speed
    delay-ms = <0>;                  // Delay before movement starts
};
```

---

## Practical Tips

1. **Start with high speed** - Easier to overshoot than undershoot
2. **Use clicks on thumbs** - Keep fingers free for movement
3. **Scroll on opposite hand** - Left hand moves, right hand scrolls (or vice versa)
4. **Add escape hatch** - Always have a way back to base layer
5. **Consider combo activation** - Cross-hand combos prevent accidental activation

## When to Use

| Task | Use Mouse Layer? |
|------|------------------|
| Click a dialog button | Yes |
| Select menu item | Yes |
| Scroll long document | Yes |
| Close a popup | Yes |
| Drag and drop | Maybe (awkward) |
| Graphics editing | No |
| Extended browsing | No (use real mouse) |
