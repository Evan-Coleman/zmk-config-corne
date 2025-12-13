# Configuration Comparison: Your Setup vs Knucklehead vs Urob

A detailed comparison of ZMK keyboard configurations to identify potential enhancements.

---

## Overview

| Aspect | Your Setup | Knucklehead | Urob |
|--------|------------|-------------|------|
| **Board** | Corne 42-key (6-col) | Corne-ish Zen 42-key | 34-key (5-col) |
| **Base Layout** | QWERTY | Colemak-DH (switchable) | QWERTY |
| **Layers** | 5 (Main, Lower, Raise, BT, Nav) | 3 (L1, L2, Fn) | 6 (DEF, Nav, Fn, Num, Sys, Mouse) |
| **HRM Style** | zmk-helpers balanced | Timer-less (urob-based) | Timer-less positional |
| **Primary OS** | macOS | macOS-optimized | Cross-platform |

---

## Feature Comparison

### Home Row Mods

| Feature | You | Knucklehead | Urob |
|---------|-----|-------------|------|
| Implementation | `ZMK_HOLD_TAP` via zmk-helpers | urob's timer-less | Native timer-less |
| Positional triggers | ✓ | ✓ | ✓ |
| Hyper key (G/H) | ✓ | ✗ | ✗ |
| `require-prior-idle-ms` | 150ms | Similar | Similar |

**Your advantage:** You have Hyper key on G/H which neither has.

---

### Smart Shift Comparison

| Behavior | You | Knucklehead | Urob |
|----------|-----|-------------|------|
| Tap = Sticky Shift | ✓ | ✓ | ✓ |
| Double-tap = Caps Word | ✓ | ✓ | ✓ |
| Hold = Shift | ✓ | ✓ | ✓ |
| Key Repeat after alpha | ✗ | ✗ | ✓ |
| Fn+tap = Caps Lock | ✗ | ✓ | ✗ |

**Enhancement opportunity:** Urob's "magic key" repeats the last letter when tapped after an alpha key. This is great for double letters like "ll" or "ss".

---

### Layer Switching

| Behavior | You | Knucklehead | Urob |
|----------|-----|-------------|------|
| Hold = momentary | ✓ | ✓ | ✓ |
| Triple-tap = toggle | ✓ | ✗ | ✗ |
| Tap = sticky layer | ✗ | ✓ | ✗ |
| Double-tap = stay active | ✗ | ✓ (for num sequences) | ✗ |
| Non-stacking layers | ✗ | ✓ (`K_CANCEL` before switch) | ✗ |

**Your advantage:** Triple-tap toggle is unique to your setup.

**Enhancement opportunity:** Knucklehead's non-stacking layers use `K_CANCEL` before switching, preventing layer confusion.

---

### Combos

| Category | You (22 combos) | Knucklehead (~20 combos) | Urob |
|----------|-----------------|-------------------------|------|
| Symbols vertical | ✓ @#$%^&* | ✓ !@#$%^&*() | Uses layers |
| Brackets | ✓ ()[]{}< > | ✓ [] only | Uses layers |
| Operators | ✓ ~\-_=+ | ✓ -=/\ | Uses layers |
| Arrow function `=>` | ✓ | ✗ | ✗ |
| Caps Word | ✓ F+J | ✗ (uses smart shift) | ✗ |
| BT selection | ✓ (4-corner) | ✓ (top row pairs) | ✗ |
| Media | ✗ | ✓ Play/Pause | Uses layer |
| Page Up/Down | ✗ | ✓ | Uses layer |

**Your advantage:** Arrow function combo and more comprehensive symbol coverage.

**Enhancement opportunities:**
1. Add Play/Pause combo (e.g., Y+U on base layer)
2. Add Page Up/Down combos if you use them frequently

---

### Symbols Layer Philosophy

| Approach | You | Knucklehead | Urob |
|----------|-----|-------------|------|
| Number row | Top row | Top row (1-5), home row (6-0) | Numpad layout |
| Shifted symbols | Separate positions | Same position, mnemonic | Mod-morphs |
| Brackets | On layer + combos | Combos only | Mod-morphs on base |
| Navigation mixed in | ✓ (Lower layer) | ✗ (separate L2) | ✗ (separate Nav) |

**Enhancement opportunity:** Consider separating navigation from symbols like knucklehead does. They keep numbers + navigation on L2, function keys on Fn.

---

### Advanced Features

| Feature | You | Knucklehead | Urob |
|---------|-----|-------------|------|
| Alt-Tab Swapper | Planned | ✗ | ✓ `tri-state` |
| Mouse Layer | Planned | ✗ | ✓ `auto-layer` |
| Num-Word | ✗ | ✓ (tap = num-word) | ✓ |
| Leader Key | Planned | ✗ | ✗ |
| Unicode | Planned | ✗ | ✓ |
| Mod-Morphs (compound) | Basic (bkspc/del) | ✗ | ✓ (extensive) |
| Tri-Layer | Planned | ✗ | ✓ (Fn+Num=Sys) |

---

## Knucklehead-Specific Features Worth Considering

### 1. Non-Stacking Layers (`K_CANCEL` Macro)

Knucklehead uses macros that cancel active smart layers before switching:

```c
// Clear Smart Layer - prevents layer stacking
csl: clear_smart_layer {
    compatible = "zmk,behavior-macro-one-param";
    #binding-cells = <1>;
    bindings = <&macro_tap &kp K_CANCEL>, <&macro_param_1to1 &to MACRO_PLACEHOLDER>;
};
```

**Benefit:** Prevents getting stuck in unexpected layer combinations. This directly addresses your pain point of "getting stuck in layers."

### 2. Layer Modifier Macro

```c
// Temporarily activate layer while holding modifier
lm: layer_modifier {
    compatible = "zmk,behavior-macro-two-param";
    #binding-cells = <2>;
    bindings = <&macro_param_1to1 &mo MACRO_PLACEHOLDER>
             , <&macro_param_2to1 &kp MACRO_PLACEHOLDER>;
};
```

**Benefit:** Allows `&lm 2 LSHIFT` to activate layer 2 while also holding shift.

### 3. Sticky Layer with Smart Behavior

Their "Smart L2" approach:
- Tap = sticky layer (one keypress, then return)
- Double-tap = stay in layer (for sequences like `123`)
- Hold = momentary

**Benefit:** More granular control than your triple-tap toggle.

### 4. Mnemonic Key Placement

Knucklehead places symbols based on visual/linguistic cues:
- `& |` opposite each other (AND/OR logic)
- `[ ]` and `{ }` as vertical combos maintaining ANSI muscle memory
- Numbers 1-5 on top row, 6-0 on home row (natural hand position)

---

## Urob-Specific Features Worth Considering

### 1. Magic Key Repeat

After typing a letter, tapping the magic key repeats it:
```
Type: "hel" + magic = "hell"
Type: "mis" + magic = "miss"
```

**Implementation:** Requires `zmk-adaptive-key` module (you already have it in west.yml)

### 2. Compound Mod-Morphs

Urob chains mod-morphs for efficiency:
```c
// Comma → Semicolon (shift) → Less-than (ctrl+shift)
comma_morph: comma_morph {
    compatible = "zmk,behavior-mod-morph";
    bindings = <&kp COMMA>, <&comma_inner>;
    mods = <(MOD_LSFT|MOD_RSFT)>;
};
comma_inner: comma_inner {
    compatible = "zmk,behavior-mod-morph";
    bindings = <&kp SEMI>, <&kp LT>;
    mods = <(MOD_LCTL|MOD_RCTL)>;
};
```

**Benefit:** One key, multiple outputs based on modifiers.

### 3. Smart Mouse with Auto-Layer

Mouse layer activates automatically when mouse keys are pressed and deactivates after idle:

```c
ZMK_AUTO_LAYER(smart_mouse, ..., MOUSE_IDLE_MS)
```

**Benefit:** No manual layer switching for mouse control.

---

## Recommendations for Your Setup

### High Priority (Address Pain Points)

1. **Add Non-Stacking Layers** ⭐
   - Implement `K_CANCEL` macro like knucklehead
   - Prevents layer confusion you mentioned
   - Simple addition to your existing layer behaviors

2. **Separate Navigation from Symbols**
   - Move navigation shortcuts off Lower layer
   - Keeps symbol layer focused and memorable
   - Consider putting nav on Raise alongside arrows

### Medium Priority (Nice to Have)

3. **Add Key Repeat to Smart Shift**
   - Upgrade `magic_key` to use `zmk-adaptive-key`
   - Great for double letters without double-tapping

4. **Add Media Combo**
   - Play/Pause on Y+U (easy to remember: "You play")
   - Volume on layer is fine, but play/pause is frequent

5. **Num-Word Mode**
   - Double-tap layer key to stay in number layer
   - Useful for entering sequences like phone numbers

### Lower Priority (Future Enhancements)

6. **Compound Mod-Morphs**
   - Chain comma → semicolon → less-than
   - Reduces layer switching for punctuation

7. **Mnemonic Layer Reorganization**
   - Consider knucklehead's 6-0 on home row approach
   - May improve number entry ergonomics

---

## Summary Table

| Feature | Priority | Complexity | Source |
|---------|----------|------------|--------|
| Non-stacking layers (`K_CANCEL`) | High | Low | Knucklehead |
| Separate nav from symbols | High | Medium | Both |
| Key repeat (adaptive key) | Medium | Medium | Urob |
| Play/Pause combo | Medium | Low | Knucklehead |
| Num-word mode | Medium | Medium | Both |
| Compound mod-morphs | Low | Medium | Urob |
| Mnemonic symbol placement | Low | High | Knucklehead |

---

## What You Have That They Don't

1. **Hyper key on G/H** - Neither knucklehead nor urob uses this
2. **Arrow function combo** (`=>`) - Unique to your setup
3. **Triple-tap layer toggle** - Your own innovation
4. **Comprehensive bracket combos** - More coverage than knucklehead
5. **6-column layout** - More keys than urob's 34-key

---

## Implementation Notes

### To Add Non-Stacking Layers

```c
// Add to corne.keymap macros section
cancel_layer: cancel_before_layer {
    compatible = "zmk,behavior-macro-one-param";
    label = "CANCEL_LAYER";
    #binding-cells = <1>;
    bindings = <&macro_tap &kp K_CANCEL>
             , <&macro_param_1to1 &to MACRO_PLACEHOLDER>;
};
```

### To Add Key Repeat

Requires modifying `magic_key` to use the `zmk-adaptive-key` module:

```c
// See .planning/features/02-smart-shift-repeat.md for details
#include "zmk-helpers/adaptive-key.h"

ZMK_ADAPTIVE_KEY(magic_key,
    bindings = <&key_repeat>, <&smart_shft>;
    ...)
```

---

## Files Referenced

- Your config: `config/corne.keymap`, `config/combos.dtsi`
- Knucklehead: https://github.com/minusfive/knucklehead
- Urob: https://github.com/urob/zmk-config
