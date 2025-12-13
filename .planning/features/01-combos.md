# Feature: Combos

## What Are Combos?

Combos are key chords - pressing two or more keys simultaneously to produce a different output. Instead of pressing Shift+2 for `@`, you could press two adjacent keys together.

## Why Use Combos?

1. **Reduce layer switching** - Access symbols without leaving your base layer
2. **Reduce finger travel** - No reaching for distant keys
3. **Faster input** - Chords can be faster than layer-tap-key sequences
4. **Preserve home row position** - Your fingers stay centered

## How Combos Work in ZMK

```c
ZMK_COMBO(name, action, key-positions, layers, timeout-ms, idle-ms)
```

- **name**: Unique identifier
- **action**: What happens (e.g., `&kp AT`)
- **key-positions**: Which keys trigger it (by position number)
- **layers**: Which layers it's active on
- **timeout-ms**: How long you have to press both keys (18-50ms typical)
- **idle-ms**: Required idle time before combo activates (prevents misfires during fast typing)

## Your 6-Column Corne Key Positions

```
╭─────────────────────────────╮ ╭─────────────────────────────╮
│  0  1  2  3  4  5           │ │  6  7  8  9 10 11           │
│ 12 13 14 15 16 17           │ │ 18 19 20 21 22 23           │
│ 24 25 26 27 28 29           │ │ 30 31 32 33 34 35           │
╰──────────╮ 36 37 38         │ │ 39 40 41 ╭──────────────────╯
           ╰──────────────────╯ ╰──────────╯

Your current layout:
╭─────────────────────────────╮ ╭─────────────────────────────╮
│  `  Q  W  E  R  T           │ │  Y  U  I  O  ;  CAPS        │
│ ESC A  S  D  F  G           │ │  H  J  K  L  P  '           │
│SHFT Z  X  C  V  B           │ │  N  M  ,  .  /  ENT         │
╰──────────╮TAB LWR SPC       │ │ BSP RSE ALT╭─────────────────╯
           ╰──────────────────╯ ╰──────────╯
```

## Combo Types

### Horizontal Combos (Adjacent Keys on Same Row)
Best for: Common actions like Escape, Backspace, Enter

```
Example: W + E (positions 2 + 3) = Escape
         I + O (positions 8 + 9) = Backspace
```

### Vertical Combos (Same Column, Different Rows)
Best for: Symbols and special characters

```
Example: W + S (positions 2 + 14) = @
         E + D (positions 3 + 15) = #
```

### Diagonal Combos (Adjacent Diagonally)
Less common, can be awkward. Use sparingly.

---

## Suggested Implementation for Your Setup

### Prerequisites
Add to `corne.keymap` before any combo usage:
```c
#include "zmk-helpers/helper.h"

// Combo timing constants
#define COMBO_TERM_FAST 18
#define COMBO_TERM_SLOW 30
#define COMBO_IDLE_FAST 150
#define COMBO_IDLE_SLOW 50
```

### Create `config/combos.dtsi`

```c
/*
 * Combos for 6-column Corne
 *
 * Key positions reference:
 * ╭─────────────────────────────╮ ╭─────────────────────────────╮
 * │  0  1  2  3  4  5           │ │  6  7  8  9 10 11           │
 * │ 12 13 14 15 16 17           │ │ 18 19 20 21 22 23           │
 * │ 24 25 26 27 28 29           │ │ 30 31 32 33 34 35           │
 * ╰──────────╮ 36 37 38         │ │ 39 40 41 ╭──────────────────╯
 *            ╰──────────────────╯ ╰──────────╯
 */

/ {
    combos {
        compatible = "zmk,combos";

        // ==================== HORIZONTAL COMBOS - LEFT HAND ====================

        // Top row
        combo_esc {
            timeout-ms = <COMBO_TERM_FAST>;
            require-prior-idle-ms = <COMBO_IDLE_FAST>;
            key-positions = <2 3>;  // W + E
            bindings = <&kp ESC>;
            layers = <0>;  // Base layer only
        };

        combo_tab {
            timeout-ms = <COMBO_TERM_FAST>;
            require-prior-idle-ms = <COMBO_IDLE_FAST>;
            key-positions = <14 15>;  // S + D
            bindings = <&kp TAB>;
            layers = <0>;
        };

        // ==================== HORIZONTAL COMBOS - RIGHT HAND ====================

        combo_bspc {
            timeout-ms = <COMBO_TERM_FAST>;
            require-prior-idle-ms = <COMBO_IDLE_FAST>;
            key-positions = <8 9>;  // I + O
            bindings = <&kp BSPC>;
            layers = <0>;
        };

        combo_del {
            timeout-ms = <COMBO_TERM_FAST>;
            require-prior-idle-ms = <COMBO_IDLE_FAST>;
            key-positions = <7 8>;  // U + I
            bindings = <&kp DEL>;
            layers = <0>;
        };

        combo_enter {
            timeout-ms = <COMBO_TERM_FAST>;
            require-prior-idle-ms = <COMBO_IDLE_FAST>;
            key-positions = <20 21>;  // K + L
            bindings = <&kp RET>;
            layers = <0>;
        };

        // ==================== VERTICAL COMBOS - SYMBOLS ====================
        // These use same-column vertical pairs for symbols

        // Left hand - top + middle row
        combo_at {
            timeout-ms = <COMBO_TERM_SLOW>;
            require-prior-idle-ms = <COMBO_IDLE_SLOW>;
            key-positions = <2 14>;  // W + S
            bindings = <&kp AT>;       // @
            layers = <0>;
        };

        combo_hash {
            timeout-ms = <COMBO_TERM_SLOW>;
            require-prior-idle-ms = <COMBO_IDLE_SLOW>;
            key-positions = <3 15>;  // E + D
            bindings = <&kp HASH>;     // #
            layers = <0>;
        };

        combo_dollar {
            timeout-ms = <COMBO_TERM_SLOW>;
            require-prior-idle-ms = <COMBO_IDLE_SLOW>;
            key-positions = <4 16>;  // R + F
            bindings = <&kp DLLR>;     // $
            layers = <0>;
        };

        combo_percent {
            timeout-ms = <COMBO_TERM_SLOW>;
            require-prior-idle-ms = <COMBO_IDLE_SLOW>;
            key-positions = <5 17>;  // T + G
            bindings = <&kp PRCNT>;    // %
            layers = <0>;
        };

        // Right hand - top + middle row
        combo_caret {
            timeout-ms = <COMBO_TERM_SLOW>;
            require-prior-idle-ms = <COMBO_IDLE_SLOW>;
            key-positions = <6 18>;  // Y + H
            bindings = <&kp CARET>;    // ^
            layers = <0>;
        };

        combo_amps {
            timeout-ms = <COMBO_TERM_SLOW>;
            require-prior-idle-ms = <COMBO_IDLE_SLOW>;
            key-positions = <7 19>;  // U + J
            bindings = <&kp AMPS>;     // &
            layers = <0>;
        };

        combo_star {
            timeout-ms = <COMBO_TERM_SLOW>;
            require-prior-idle-ms = <COMBO_IDLE_SLOW>;
            key-positions = <8 20>;  // I + K
            bindings = <&kp STAR>;     // *
            layers = <0>;
        };

        // Left hand - middle + bottom row
        combo_grave {
            timeout-ms = <COMBO_TERM_SLOW>;
            require-prior-idle-ms = <COMBO_IDLE_SLOW>;
            key-positions = <14 26>;  // S + X
            bindings = <&kp GRAVE>;    // `
            layers = <0>;
        };

        combo_tilde {
            timeout-ms = <COMBO_TERM_SLOW>;
            require-prior-idle-ms = <COMBO_IDLE_SLOW>;
            key-positions = <15 27>;  // D + C
            bindings = <&kp TILDE>;    // ~
            layers = <0>;
        };

        combo_bslh {
            timeout-ms = <COMBO_TERM_SLOW>;
            require-prior-idle-ms = <COMBO_IDLE_SLOW>;
            key-positions = <16 28>;  // F + V
            bindings = <&kp BSLH>;     // \
            layers = <0>;
        };

        // Right hand - middle + bottom row
        combo_minus {
            timeout-ms = <COMBO_TERM_SLOW>;
            require-prior-idle-ms = <COMBO_IDLE_SLOW>;
            key-positions = <19 31>;  // J + M
            bindings = <&kp MINUS>;    // -
            layers = <0>;
        };

        combo_under {
            timeout-ms = <COMBO_TERM_SLOW>;
            require-prior-idle-ms = <COMBO_IDLE_SLOW>;
            key-positions = <20 32>;  // K + ,
            bindings = <&kp UNDER>;    // _
            layers = <0>;
        };

        combo_equal {
            timeout-ms = <COMBO_TERM_SLOW>;
            require-prior-idle-ms = <COMBO_IDLE_SLOW>;
            key-positions = <21 33>;  // L + .
            bindings = <&kp EQUAL>;    // =
            layers = <0>;
        };

        combo_plus {
            timeout-ms = <COMBO_TERM_SLOW>;
            require-prior-idle-ms = <COMBO_IDLE_SLOW>;
            key-positions = <22 34>;  // P + /
            bindings = <&kp PLUS>;     // +
            layers = <0>;
        };

        // ==================== BRACKET COMBOS ====================
        // Adjacent keys for paired characters

        combo_lpar {
            timeout-ms = <COMBO_TERM_SLOW>;
            require-prior-idle-ms = <COMBO_IDLE_SLOW>;
            key-positions = <3 4>;  // E + R
            bindings = <&kp LPAR>;     // (
            layers = <0>;
        };

        combo_rpar {
            timeout-ms = <COMBO_TERM_SLOW>;
            require-prior-idle-ms = <COMBO_IDLE_SLOW>;
            key-positions = <7 8>;  // U + I  (also del, might want different)
            bindings = <&kp RPAR>;     // )
            layers = <0>;
        };

        combo_lbkt {
            timeout-ms = <COMBO_TERM_SLOW>;
            require-prior-idle-ms = <COMBO_IDLE_SLOW>;
            key-positions = <15 16>;  // D + F
            bindings = <&kp LBKT>;     // [
            layers = <0>;
        };

        combo_rbkt {
            timeout-ms = <COMBO_TERM_SLOW>;
            require-prior-idle-ms = <COMBO_IDLE_SLOW>;
            key-positions = <19 20>;  // J + K
            bindings = <&kp RBKT>;     // ]
            layers = <0>;
        };

        combo_lbrc {
            timeout-ms = <COMBO_TERM_SLOW>;
            require-prior-idle-ms = <COMBO_IDLE_SLOW>;
            key-positions = <27 28>;  // C + V
            bindings = <&kp LBRC>;     // {
            layers = <0>;
        };

        combo_rbrc {
            timeout-ms = <COMBO_TERM_SLOW>;
            require-prior-idle-ms = <COMBO_IDLE_SLOW>;
            key-positions = <32 33>;  // , + .
            bindings = <&kp RBRC>;     // }
            layers = <0>;
        };

        // ==================== YOUR EXISTING COMBO (preserved) ====================

        bt_combo {
            bindings = <&to 3>;
            key-positions = <0 1 10 11>;  // Corner keys for BT layer
        };

        // ==================== UTILITY COMBOS ====================

        combo_caps_word {
            timeout-ms = <COMBO_TERM_FAST>;
            require-prior-idle-ms = <COMBO_IDLE_FAST>;
            key-positions = <16 19>;  // F + J (home position index fingers)
            bindings = <&caps_word>;
            layers = <0>;
        };
    };
};
```

### Include in corne.keymap

```c
// After #include "base.keymap"
#include "combos.dtsi"
```

---

## Tips for Learning Combos

1. **Start small** - Add 3-5 combos, use them for a week
2. **Use muscle memory shortcuts** - Put frequent symbols on easy-to-reach combos
3. **Vertical > horizontal for symbols** - Less chance of accidental triggers while typing
4. **Tune timing** - If you get misfires, increase `require-prior-idle-ms`

## Common Issues

| Problem | Solution |
|---------|----------|
| Combo triggers while typing fast | Increase `require-prior-idle-ms` to 150-200 |
| Combo doesn't trigger reliably | Decrease `timeout-ms` or use more distinct key pairs |
| Combos interfere with rolls | Avoid horizontal combos on letter pairs you type often |

## Visual Reference Card

```
VERTICAL COMBOS (top + home row):
╭────────────────────────╮ ╭────────────────────────╮
│     @  #  $  %         │ │  ^  &  *               │
│     W  E  R  T         │ │  Y  U  I               │
│     │  │  │  │         │ │  │  │  │               │
│     S  D  F  G         │ │  H  J  K               │
╰────────────────────────╯ ╰────────────────────────╯

VERTICAL COMBOS (home + bottom row):
╭────────────────────────╮ ╭────────────────────────╮
│     `  ~  \            │ │  -  _  =  +            │
│     S  D  F            │ │  J  K  L  P            │
│     │  │  │            │ │  │  │  │  │            │
│     X  C  V            │ │  M  ,  .  /            │
╰────────────────────────╯ ╰────────────────────────╯

HORIZONTAL COMBOS:
╭────────────────────────╮ ╭────────────────────────╮
│    ESC    (  )         │ │        DEL BSP         │
│    W─E    E─R          │ │        U─I I─O         │
│                        │ │                        │
│    TAB    [  ]         │ │        [  ]  ENTER     │
│    S─D    D─F          │ │       J─K   K─L        │
│                        │ │                        │
│           {  }         │ │           {  }         │
│          C─V           │ │          ,─.           │
╰────────────────────────╯ ╰────────────────────────╯
```
