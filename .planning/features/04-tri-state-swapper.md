# Feature: Tri-State Swapper (Alt-Tab Handler)

## What Is It?

A specialized behavior for window switching that:
1. **First tap**: Holds Alt and taps Tab (starts switcher)
2. **Additional taps**: Tabs through windows (Alt stays held)
3. **Release/timeout**: Releases Alt (selects window)

This mimics how Alt-Tab works on a regular keyboard but with a single key.

## Why Use It?

### The Problem with Standard Alt-Tab on HRM

With home row mods, Alt is on your D key (left) or K key (right):
- You must hold D, then reach for Tab with your ring finger
- Awkward hand position
- Can't easily Tab multiple times while holding Alt

### The Solution

One key that manages the entire Alt-Tab dance:
- Tap once → Alt-Tab (switcher appears)
- Keep tapping → Cycle through windows
- Stop → Window selected

**No holding required!**

---

## How It Works (State Machine)

```
[Idle] --tap--> [Alt held, Tab sent] --tap--> [Tab sent again]
                        |                            |
                        v                            v
              (timeout/other key)          (timeout/other key)
                        |                            |
                        v                            v
                  [Alt released]               [Alt released]
```

---

## Implementation for Your Setup

### Required Module

You have `zmk-tri-state` in your `west.yml`:
```yaml
- name: zmk-tri-state
  path: modules/zmk/tri-state
```

### Basic Implementation

Add to your `corne.keymap`:

```c
/ {
    behaviors {
        // Alt-Tab swapper
        swapper: swapper {
            compatible = "zmk,behavior-tri-state";
            label = "SWAPPER";
            #binding-cells = <0>;
            bindings = <&kt LALT>, <&kp TAB>, <&kt LALT>;
            ignored-key-positions = <>;  // Keys that don't cancel the swapper
            timeout-ms = <500>;  // Auto-release Alt after 500ms of inactivity
        };
    };
};
```

### With Shift Support (Reverse Direction)

To allow Shift+Swapper for reverse cycling:

```c
/ {
    behaviors {
        swapper: swapper {
            compatible = "zmk,behavior-tri-state";
            label = "SWAPPER";
            #binding-cells = <0>;
            bindings = <&kt LALT>, <&kp TAB>, <&kt LALT>;
            // Allow these keys to be pressed without canceling
            // Position 13 = A (left shift on HRM)
            ignored-key-positions = <13 24>;  // Your shift positions
            timeout-ms = <500>;
        };
    };
};
```

Now: Swapper = Tab forward, Shift + Swapper = Tab backward

---

## Placement Options

### Option 1: On Raise Layer (Navigation Area)

Your Raise layer has navigation keys. Add swapper near arrows:

```c
Raise {
    bindings = <
&kp F1  &kp F2  &kp F3  &kp F4  &kp F5  &kp F6     &kp F7   &kp F8   &kp F9  &kp F10  &kp F11  &kp F12
&trans  ...                                        &kp LEFT &kp DOWN &kp UP  &kp RIGHT &swapper &back_forward
...
    >;
};
```

Position: Right pinky on Raise layer (replaces RIGHT_SHIFT or use an empty slot)

### Option 2: Combo on Base Layer

Trigger swapper with a two-key combo:

```c
combos {
    compatible = "zmk,combos";

    combo_swapper {
        timeout-ms = <50>;
        require-prior-idle-ms = <100>;
        key-positions = <15 16>;  // D + F
        bindings = <&swapper>;
        layers = <0>;  // Base layer
    };
};
```

**Why D+F?** It's where your Alt finger naturally rests!

### Option 3: Replace Existing Key

Your `caps_ptsc` (position 11) might be a good swap since Caps Word is more useful:

```c
// Top right corner
&kp GRAVE  &kp Q  &kp W  &kp E  &kp R  &kp T    &kp Y  &kp U  &kp I  &kp O  &kp SEMI  &swapper
```

---

## macOS vs Windows

### For Windows (Default)
```c
bindings = <&kt LALT>, <&kp TAB>, <&kt LALT>;
```

### For macOS (Cmd-Tab)
```c
bindings = <&kt LGUI>, <&kp TAB>, <&kt LGUI>;
```

### Dual-Boot Setup

Create two swappers and place them on OS-specific layers or use a toggle:

```c
/ {
    behaviors {
        win_swap: windows_swapper {
            compatible = "zmk,behavior-tri-state";
            label = "WIN_SWAP";
            #binding-cells = <0>;
            bindings = <&kt LALT>, <&kp TAB>, <&kt LALT>;
            timeout-ms = <500>;
        };

        mac_swap: mac_swapper {
            compatible = "zmk,behavior-tri-state";
            label = "MAC_SWAP";
            #binding-cells = <0>;
            bindings = <&kt LGUI>, <&kp TAB>, <&kt LGUI>;
            timeout-ms = <500>;
        };
    };
};
```

---

## Usage Flow

```
Scenario: Switch from Browser to Terminal

1. You're in Chrome, want Terminal
2. Tap [swapper] → Alt held + Tab sent → Switcher appears
3. See Terminal? Stop tapping → Alt releases → Terminal focused
4. Don't see it? Tap [swapper] again → Cycles to next window
5. Want to go back? Hold Shift + tap [swapper] → Cycles backward
```

---

## Advanced: Swapper with Reverse Key

Instead of using Shift, dedicate a second key for reverse:

```c
/ {
    behaviors {
        // Forward swapper
        sw_fwd: swapper_forward {
            compatible = "zmk,behavior-tri-state";
            label = "SWAP_FWD";
            #binding-cells = <0>;
            bindings = <&kt LALT>, <&kp TAB>, <&kt LALT>;
            ignored-key-positions = <40>;  // Position of reverse key
            timeout-ms = <500>;
        };

        // Reverse (Shift-Tab while Alt held)
        sw_rev: swapper_reverse {
            compatible = "zmk,behavior-tri-state";
            label = "SWAP_REV";
            #binding-cells = <0>;
            bindings = <&kt LALT>, <&kp LS(TAB)>, <&kt LALT>;
            ignored-key-positions = <37>;  // Position of forward key
            timeout-ms = <500>;
        };
    };
};
```

Now you can:
- Tap sw_fwd → Cycle forward
- Tap sw_rev → Cycle backward
- Mix them: fwd, fwd, rev, fwd → Precise window targeting

---

## Timing Tuning

### Timeout
```c
timeout-ms = <500>;   // Default: 500ms
timeout-ms = <1000>;  // Slower: More time to decide
timeout-ms = <300>;   // Faster: Quick switches
```

If switcher closes before you select:
- Increase timeout
- Or tap faster

### With Other Behaviors

The swapper automatically releases when you:
1. Press a non-ignored key
2. Timeout expires
3. Press the same key that triggered it (some implementations)

---

## Comparison with Regular Alt-Tab

| Action | Regular Keyboard | With Swapper |
|--------|------------------|--------------|
| Start | Hold Alt + tap Tab | Tap once |
| Cycle forward | Keep holding + tap Tab | Tap again |
| Cycle backward | Keep holding + Shift + Tab | Shift + tap |
| Select | Release Alt | Stop tapping (or timeout) |
| Cancel | Escape (while holding) | Escape or any other key |

---

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Swapper doesn't start | Check binding syntax, ensure module is loaded |
| Alt stays stuck | Increase timeout, or tap any key to release |
| Shift doesn't reverse | Add shift key position to `ignored-key-positions` |
| Wrong modifier (Win vs Mac) | Change `LALT` to `LGUI` for macOS |
| Interferes with other keys | Review and adjust `ignored-key-positions` |

---

## Is It Worth It?

**Yes, if:**
- You frequently switch between 2-4 windows
- You find holding Alt awkward with HRM
- You want one-handed window switching

**Maybe not, if:**
- You have many windows and need precise selection (use mouse)
- You prefer the visual feedback of holding Alt
- You're already comfortable with existing shortcuts
