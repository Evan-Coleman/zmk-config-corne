# Feature: Unicode Character Input

## What Is It?

Direct input of Unicode characters from your keyboard:
- Special symbols: € £ © ® ™
- Math symbols: ≠ ≈ ≤ ≥ ± ÷ ×
- Arrows: → ← ↑ ↓ ⇒ ⇐
- Accented characters: é ü ñ ç
- Emojis: 😀 👍 (OS dependent)

## Why Use It?

1. **No character picker** - Don't search through emoji menus
2. **Consistent input** - Same keystroke every time
3. **Programming symbols** - ≠, ∈, λ for functional programming
4. **International characters** - Accented letters for multilingual typing
5. **Professional writing** - Proper symbols like © ™ €

## When to Use It

**Good for:**
- Writing documentation with special characters
- International language input
- Math/science notation
- Consistent emoji insertion

**Limitations:**
- OS-specific input methods
- Some applications don't accept all Unicode
- Setup complexity

---

## How Unicode Input Works

### OS Input Methods

Each OS has a different method for Unicode input:

| OS | Method | Sequence |
|-----|--------|----------|
| **Linux** | Ctrl+Shift+U | Ctrl+Shift+U, hex code, Space/Enter |
| **macOS** | Option codes | Hold Option, type hex code |
| **Windows** | Alt codes (limited) | Hold Alt, type decimal on numpad |
| **Windows** | WinCompose | Custom sequences |

### ZMK Unicode Module

Uses macros to send the appropriate key sequences for your OS.

---

## Implementation for Your Setup

### Required Module

You have `zmk-unicode` in your `west.yml`:
```yaml
- name: zmk-unicode
  path: modules/zmk/unicode
```

### Configure for Your OS

Create `config/unicode.dtsi`:

```c
// config/unicode.dtsi
// Unicode character definitions

// Set your OS (uncomment one)
#define UNICODE_TARGET_OS_LINUX  // For Linux with IBus/fcitx
// #define UNICODE_TARGET_OS_MAC  // For macOS
// #define UNICODE_TARGET_OS_WIN  // For Windows with WinCompose

#include <dt-bindings/zmk/unicode.h>

/ {
    macros {
        // ============ CURRENCY SYMBOLS ============

        // Euro: €
        uc_euro: unicode_euro {
            compatible = "zmk,behavior-macro";
            label = "UC_EURO";
            #binding-cells = <0>;
            #ifdef UNICODE_TARGET_OS_LINUX
            bindings = <&macro_press &kp LCTRL &kp LSHFT>
                     , <&macro_tap &kp U>
                     , <&macro_release &kp LCTRL &kp LSHFT>
                     , <&macro_tap &kp N2 &kp N0 &kp A &kp C>
                     , <&macro_tap &kp SPACE>;
            #endif
            #ifdef UNICODE_TARGET_OS_MAC
            bindings = <&macro_press &kp LALT>
                     , <&macro_tap &kp N2 &kp N0 &kp A &kp C>
                     , <&macro_release &kp LALT>;
            #endif
        };

        // Pound: £
        uc_pound: unicode_pound {
            compatible = "zmk,behavior-macro";
            label = "UC_POUND";
            #binding-cells = <0>;
            #ifdef UNICODE_TARGET_OS_LINUX
            bindings = <&macro_press &kp LCTRL &kp LSHFT>
                     , <&macro_tap &kp U>
                     , <&macro_release &kp LCTRL &kp LSHFT>
                     , <&macro_tap &kp N0 &kp N0 &kp A &kp N3>
                     , <&macro_tap &kp SPACE>;
            #endif
        };

        // ============ MATH SYMBOLS ============

        // Not equal: ≠
        uc_neq: unicode_not_equal {
            compatible = "zmk,behavior-macro";
            label = "UC_NEQ";
            #binding-cells = <0>;
            #ifdef UNICODE_TARGET_OS_LINUX
            bindings = <&macro_press &kp LCTRL &kp LSHFT>
                     , <&macro_tap &kp U>
                     , <&macro_release &kp LCTRL &kp LSHFT>
                     , <&macro_tap &kp N2 &kp N2 &kp N6 &kp N0>
                     , <&macro_tap &kp SPACE>;
            #endif
        };

        // Less than or equal: ≤
        uc_leq: unicode_less_equal {
            compatible = "zmk,behavior-macro";
            label = "UC_LEQ";
            #binding-cells = <0>;
            #ifdef UNICODE_TARGET_OS_LINUX
            bindings = <&macro_press &kp LCTRL &kp LSHFT>
                     , <&macro_tap &kp U>
                     , <&macro_release &kp LCTRL &kp LSHFT>
                     , <&macro_tap &kp N2 &kp N2 &kp N6 &kp N4>
                     , <&macro_tap &kp SPACE>;
            #endif
        };

        // Greater than or equal: ≥
        uc_geq: unicode_greater_equal {
            compatible = "zmk,behavior-macro";
            label = "UC_GEQ";
            #binding-cells = <0>;
            #ifdef UNICODE_TARGET_OS_LINUX
            bindings = <&macro_press &kp LCTRL &kp LSHFT>
                     , <&macro_tap &kp U>
                     , <&macro_release &kp LCTRL &kp LSHFT>
                     , <&macro_tap &kp N2 &kp N2 &kp N6 &kp N5>
                     , <&macro_tap &kp SPACE>;
            #endif
        };

        // ============ ARROWS ============

        // Right arrow: →
        uc_rarr: unicode_right_arrow {
            compatible = "zmk,behavior-macro";
            label = "UC_RARR";
            #binding-cells = <0>;
            #ifdef UNICODE_TARGET_OS_LINUX
            bindings = <&macro_press &kp LCTRL &kp LSHFT>
                     , <&macro_tap &kp U>
                     , <&macro_release &kp LCTRL &kp LSHFT>
                     , <&macro_tap &kp N2 &kp N1 &kp N9 &kp N2>
                     , <&macro_tap &kp SPACE>;
            #endif
        };

        // Left arrow: ←
        uc_larr: unicode_left_arrow {
            compatible = "zmk,behavior-macro";
            label = "UC_LARR";
            #binding-cells = <0>;
            #ifdef UNICODE_TARGET_OS_LINUX
            bindings = <&macro_press &kp LCTRL &kp LSHFT>
                     , <&macro_tap &kp U>
                     , <&macro_release &kp LCTRL &kp LSHFT>
                     , <&macro_tap &kp N2 &kp N1 &kp N9 &kp N0>
                     , <&macro_tap &kp SPACE>;
            #endif
        };

        // ============ COMMON SYMBOLS ============

        // Degree: °
        uc_deg: unicode_degree {
            compatible = "zmk,behavior-macro";
            label = "UC_DEGREE";
            #binding-cells = <0>;
            #ifdef UNICODE_TARGET_OS_LINUX
            bindings = <&macro_press &kp LCTRL &kp LSHFT>
                     , <&macro_tap &kp U>
                     , <&macro_release &kp LCTRL &kp LSHFT>
                     , <&macro_tap &kp N0 &kp N0 &kp B &kp N0>
                     , <&macro_tap &kp SPACE>;
            #endif
        };

        // Copyright: ©
        uc_copy: unicode_copyright {
            compatible = "zmk,behavior-macro";
            label = "UC_COPY";
            #binding-cells = <0>;
            #ifdef UNICODE_TARGET_OS_LINUX
            bindings = <&macro_press &kp LCTRL &kp LSHFT>
                     , <&macro_tap &kp U>
                     , <&macro_release &kp LCTRL &kp LSHFT>
                     , <&macro_tap &kp N0 &kp N0 &kp A &kp N9>
                     , <&macro_tap &kp SPACE>;
            #endif
        };
    };
};
```

### Using with zmk-helpers (Simpler Syntax)

If using urob's zmk-helpers with unicode support:

```c
#include "zmk-helpers/helper.h"
#include "zmk-helpers/unicode.h"

// Single character (lowercase only)
ZMK_UNICODE_SINGLE(uc_euro, N2 N0 A C)        // € (U+20AC)
ZMK_UNICODE_SINGLE(uc_pound, N0 N0 A N3)      // £ (U+00A3)
ZMK_UNICODE_SINGLE(uc_neq, N2 N2 N6 N0)       // ≠ (U+2260)

// Character pair (lowercase/uppercase)
ZMK_UNICODE_PAIR(uc_a_umlaut, N0 N0 E N4, N0 N0 C N4)  // ä/Ä
ZMK_UNICODE_PAIR(uc_o_umlaut, N0 N0 F N6, N0 N0 D N6)  // ö/Ö
```

---

## Placement Options

### Option 1: Leader Key Sequences

Best for occasional use:

```c
// In leader.dtsi
bindings =
    <&uc_euro E U>,      // leader → e → u = €
    <&uc_pound P U>,     // leader → p → u = £
    <&uc_neq N E>,       // leader → n → e = ≠
    <&uc_deg D E>,       // leader → d → e = °
    <&uc_rarr MINUS GT>; // leader → - → > = →
```

### Option 2: Dedicated Layer

For heavy Unicode users:

```c
Unicode {
    label = "Unicode";
    bindings = <
//╭────────┬────────┬────────┬────────┬────────┬────────╮ ╭────────┬────────┬────────┬────────┬────────┬────────╮
   &to BASE &uc_euro &uc_pound &none   &none    &none      &none    &none    &none    &none    &none    &none
//├────────┼────────┼────────┼────────┼────────┼────────┤ ├────────┼────────┼────────┼────────┼────────┼────────┤
   &none    &uc_larr &uc_neq  &uc_leq  &uc_geq  &uc_rarr   &none    &none    &none    &none    &none    &none
//├────────┼────────┼────────┼────────┼────────┼────────┤ ├────────┼────────┼────────┼────────┼────────┼────────┤
   &none    &uc_deg  &uc_copy &none    &none    &none      &none    &none    &none    &none    &none    &none
//╰────────┴────────┴────────┼────────┼────────┼────────┤ ├────────┼────────┼────────┼────────┴────────┴────────╯
                              &to BASE &none    &none      &none    &none    &to BASE
//                           ╰────────┴────────┴────────╯ ╰────────┴────────┴────────╯
    >;
};
```

### Option 3: Combos for Most-Used

```c
combos {
    combo_euro {
        timeout-ms = <50>;
        key-positions = <3 4>;  // E + R (mnemonic: Euro)
        bindings = <&uc_euro>;
        layers = <LOWER>;  // Only on symbols layer
    };

    combo_arrow {
        timeout-ms = <50>;
        key-positions = <33 34>;  // . + / (mnemonic: point direction)
        bindings = <&uc_rarr>;
        layers = <0>;
    };
};
```

---

## Unicode Code Reference

### Common Characters

| Symbol | Unicode | Hex Code |
|--------|---------|----------|
| € | U+20AC | 20AC |
| £ | U+00A3 | 00A3 |
| ¥ | U+00A5 | 00A5 |
| © | U+00A9 | 00A9 |
| ® | U+00AE | 00AE |
| ™ | U+2122 | 2122 |
| ° | U+00B0 | 00B0 |

### Math Symbols

| Symbol | Unicode | Hex Code |
|--------|---------|----------|
| ≠ | U+2260 | 2260 |
| ≈ | U+2248 | 2248 |
| ≤ | U+2264 | 2264 |
| ≥ | U+2265 | 2265 |
| ± | U+00B1 | 00B1 |
| ÷ | U+00F7 | 00F7 |
| × | U+00D7 | 00D7 |
| √ | U+221A | 221A |

### Arrows

| Symbol | Unicode | Hex Code |
|--------|---------|----------|
| → | U+2192 | 2192 |
| ← | U+2190 | 2190 |
| ↑ | U+2191 | 2191 |
| ↓ | U+2193 | 2193 |
| ⇒ | U+21D2 | 21D2 |
| ⇐ | U+21D0 | 21D0 |

### Accented Characters

| Symbol | Unicode | Hex Code |
|--------|---------|----------|
| é | U+00E9 | 00E9 |
| ü | U+00FC | 00FC |
| ñ | U+00F1 | 00F1 |
| ç | U+00E7 | 00E7 |
| ö | U+00F6 | 00F6 |
| ä | U+00E4 | 00E4 |

---

## OS-Specific Setup

### Linux
1. Ensure IBus or fcitx is your input method
2. Configure Unicode input method in settings
3. Test: Ctrl+Shift+U, type 20AC, Enter → Should produce €

### macOS
1. System Preferences → Keyboard → Input Sources
2. Add "Unicode Hex Input"
3. Switch to Unicode input method when needed
4. Hold Option, type hex code

### Windows
**Option A: WinCompose**
1. Install WinCompose (free)
2. Enables Unix-style compose sequences
3. Configure ZMK to use WinCompose triggers

**Option B: Alt Codes (Limited)**
1. Only works with numpad
2. Only supports characters < 256
3. Not recommended for full Unicode

---

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Nothing happens | Check OS Unicode input is configured |
| Wrong character | Verify hex code is correct |
| Only works sometimes | Check active input method |
| Works in some apps | Some apps don't support all Unicode |

---

## Is It Worth It?

**Yes, if:**
- You frequently type special characters
- You write in multiple languages
- You use math/technical symbols
- You want consistent input method

**Maybe not, if:**
- You rarely need special characters
- Your OS picker is fast enough
- You're on Windows without WinCompose
- Setup complexity isn't worth the benefit

**Recommendation:** Start with 3-5 most-used characters (€, →, ≠) and expand if useful.
