# Feature: Smart Shift / Repeat Key (Magic Key)

## What Is It?

A single key that changes behavior based on context:
- **After typing a letter**: Repeats that letter
- **After anything else**: Acts as sticky shift
- **When held**: Standard shift
- **Double-tapped**: Activates Caps Word

This eliminates the need for a dedicated repeat key AND makes shift more accessible.

## Why Use It?

### The Problem with Standard Shift
With home row mods, you already have shift on your pinkies. But:
- Holding shift while typing can slow you down
- Double letters require lifting and re-pressing the same finger
- You have a "wasted" thumb key (your right alt is redundant with HRM)

### The Solution
One key that intelligently provides:
1. **Key repeat** - Type "ll" as L + repeat (faster than L, L)
2. **Sticky shift** - Tap for one capital letter without holding
3. **Hold shift** - Traditional behavior when needed
4. **Caps word** - Double-tap for programming_CONSTANTS

## How It Works

The `zmk-adaptive-key` module watches what you typed last:
- Last key was A-Z? Repeat it.
- Last key was anything else (space, number, symbol)? Sticky shift.

```
You type: "hello"  → h-e-l-l-o
With repeat: h-e-l-[repeat]-o  → Same result, one less keypress

You type: "Hello"
With sticky: [smart-shift]-h-e-l-l-o → Shift only applies to 'h'
```

---

## Implementation for Your Setup

### Perfect Placement: Right Thumb Alt Key

Your current right thumb cluster:
```
│ BSPC  RSE  ALT │
│  39   40   41  │
```

You noted the ALT key (position 41) is useless since you have Alt on your home row. Perfect spot for smart shift!

### Required Module

You already have `zmk-adaptive-key` in your `west.yml`:
```yaml
- name: zmk-adaptive-key
  path: modules/zmk/adaptive-key
```

### Add to corne.keymap

```c
// First, include the helper if not already done
#include "zmk-helpers/helper.h"

// Define the smart shift behavior
/ {
    behaviors {
        // Smart Shift / Magic Key
        // - After alpha: repeat last key
        // - Otherwise: sticky shift
        // - Hold: regular shift
        // - Double-tap: caps word
        smart_shft: smart_shift {
            compatible = "zmk,behavior-antecedent-morph";
            label = "SMART_SHIFT";
            #binding-cells = <0>;
            defaults = <&sk LSHFT>;  // Default: sticky shift
            bindings = <&key_repeat>;  // After letters: repeat
            antecedents = <
                A B C D E F G H I J K L M
                N O P Q R S T U V W X Y Z
            >;
            max-delay-ms = <500>;  // Must follow letter within 500ms
        };

        // Hold-tap wrapper for shift hold + smart_shft tap
        smart_shft_ht: smart_shift_hold_tap {
            compatible = "zmk,behavior-hold-tap";
            label = "SMART_SHIFT_HT";
            #binding-cells = <2>;
            flavor = "balanced";
            tapping-term-ms = <200>;
            bindings = <&kp>, <&smart_shft>;
        };

        // Tap-dance for double-tap caps word
        magic_key: magic_key {
            compatible = "zmk,behavior-tap-dance";
            label = "MAGIC_KEY";
            #binding-cells = <0>;
            tapping-term-ms = <200>;
            bindings = <&smart_shft_ht LSHFT 0>, <&caps_word>;
        };
    };
};
```

### Update Your Keymap

Replace your right thumb ALT with the magic key:

```c
// In your Main layer, change:
// FROM:
&bkspc_del  &mom_or_to 2 2  &kp RIGHT_ALT

// TO:
&bkspc_del  &mom_or_to 2 2  &magic_key
```

---

## Behavior Summary

| Action | Result |
|--------|--------|
| Tap after letter | Repeat that letter |
| Tap after space/number/symbol | Sticky shift (next key capitalized) |
| Hold | Standard left shift |
| Double-tap | Caps word mode |

## Usage Examples

### Typing Double Letters
```
Traditional: l → l → (lift and press again)
With repeat: l → magic → (no finger lift needed)

Words with doubles: "coffee" → c-o-f-[magic]-e-e
                    "letter" → l-e-t-[magic]-e-r
```

### Quick Capitalization
```
Traditional: Hold shift → type letter → release shift
With sticky: Tap magic → type letter (shift auto-releases)

"The" → [magic]-t-h-e (only T is capitalized)
```

### Programming Constants
```
Double-tap magic → type CONSTANT_NAME
Caps Word automatically deactivates after space or punctuation (except _)

"MY_CONSTANT" → [magic][magic]-m-y-_-c-o-n-s-t-a-n-t
```

---

## Tuning

### Adjust Repeat Timing
If repeat triggers when you don't want it (typing slowly):
```c
max-delay-ms = <300>;  // Shorter window (default 500)
```

### Adjust Hold Timing
If hold-shift triggers when you want tap:
```c
tapping-term-ms = <250>;  // Longer = more time for tap (default 200)
```

---

## Alternative: Simpler Version (No Repeat)

If you don't want the repeat feature, use plain sticky shift with caps word:

```c
/ {
    behaviors {
        smart_shft: smart_shift {
            compatible = "zmk,behavior-tap-dance";
            label = "SMART_SHIFT";
            #binding-cells = <0>;
            tapping-term-ms = <200>;
            bindings = <&sk LSHFT>, <&caps_word>;
        };
    };
};

// Then in keymap:
&bkspc_del  &mom_or_to 2 2  &smart_shft
```

This version:
- Tap: Sticky shift
- Double-tap: Caps word
- No hold behavior (simpler)

---

## Why This Position?

Your right thumb ALT is ideal because:
1. **Redundant with HRM** - You have Alt on your home row (D and K positions)
2. **Easy reach** - Thumb position for frequent use
3. **Symmetry** - Shift is traditionally right-handed anyway
4. **Frees cognitive load** - One less modifier to think about

## Compatibility Notes

- Works with your existing HRM setup
- Does not conflict with home row mods
- Caps Word continues letters, numbers, underscore, backspace
- Repeat works with any key that produces a keycode
