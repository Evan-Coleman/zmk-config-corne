# ZMK Config Enhancement Progress

## Phase 1: Foundation ✓ Complete

- [x] Fix build errors (helper.h, QUICK_TAP_MS, 42.h key-labels)
- [x] Layer switching: triple-tap for sticky, otherwise hold
- [x] Replace right thumb ALT with Smart Shift
- [x] Add coding symbol combos (prioritized for Swift/JS/Java)
- [x] Add Caps Word combo (F+J) + configure continue-list
- [x] Build verified passing (GitHub Actions)

## Phase 2: Comfort Features ✓ Complete

- [x] Tri-layer setup (Lower+Raise = BT)
- [x] Cmd-Tab swapper (on Lower layer: N=swap, M=reverse)
- [x] ESC combo (W+E)
- [x] Backspace combo (I+O)
- [x] Enter combo (K+L)
- [x] Build verified passing

## Phase 3: Advanced Features ✓ Complete

- [x] Mouse layer with auto-toggle (layer 5, access via Raise+Z)
- [x] Leader key sequences (access via Raise+N)
- [x] Key repeat functionality (tap magic key after alpha = repeat)
- [ ] Unicode characters (skipped - OS-dependent complexity)

## Phase 4: Polish

- [ ] Reorganize symbols layer
- [ ] Add visual reference cards
- [ ] Local nix build setup
- [ ] Keymap drawer visualization

---

## Feature Summary

| Feature | Description | Status |
|---------|-------------|--------|
| **Build Fix** | helper.h, QUICK_TAP_MS, 42.h key-labels for 6-col | Done |
| **Layer Hold** | Hold=momentary, triple-tap=toggle | Done |
| **Smart Shift** | Tap=sticky shift, hold=shift, double-tap=caps word | Done |
| **Symbol Combos** | @#$%^&* + brackets + operators for iOS/JS/Java | Done |
| **Caps Word** | F+J combo, continues on underscore/minus | Done |
| **Tri-Layer** | Hold both thumbs = BT layer | Done |
| **Swapper** | Cmd-Tab cycling (Lower: N=fwd, M=rev) | Done |
| **Comfort Combos** | W+E=ESC, I+O=BSPC, K+L=ENTER | Done |
| **Mouse Layer** | WASD control, auto-deactivate (Raise+Z) | Done |
| **Leader Key** | BT, screenshot, lock sequences (Raise+N) | Done |
| **Key Repeat** | Tap magic after alpha = repeat letter | Done |

---

## Symbol Combos Quick Reference (Phase 1)

```
VERTICAL (top + home row):
W+S=@  E+D=#  R+F=$  T+G=%  Y+H=^  U+J=&  I+K=*

BRACKETS (horizontal adjacent):
E+R=(  U+I=)   D+F=[  J+K=]   C+V={  ,+.=}   R+T=<  Y+U=>

OPERATORS (home + bottom):
D+C=~  F+V=\  J+M=-  K+,=_  L+.==  P+/=+

SPECIAL:
.+/ = =>  (arrow function)
F+J = Caps Word

COMFORT (Phase 2):
W+E = ESC   I+O = BSPC   K+L = ENTER
```

## Swapper Quick Reference (Phase 2)

```
On Lower layer (hold left thumb):
N = Cmd-Tab swapper (tap to start, keep tapping to cycle)
M = Shift+Tab (reverse direction while in swapper)
Any other key = Confirm selection and release Cmd

Tri-Layer:
Hold Lower + Raise simultaneously = BT layer
```

## Phase 3 Quick Reference

### Mouse Layer (Raise + Z to activate)
```
Left Hand:           Right Hand:
  W=↑                  U=scroll←  I=scroll↓  O=scroll↑  P=scroll→
A=← S=↓ D=→           J=left-click  K=middle  L=right-click
  +modifiers           +modifiers

Auto-deactivates when you press any non-mouse key!
```

### Leader Key Sequences (Raise + N to start)
```
Bluetooth:          Screenshots (macOS):    System:
b → 0 = BT slot 0   s → s = Full screen     r → s → t = Reset
b → 1 = BT slot 1   s → a = Area select     b → o → t = Bootloader
b → 2 = BT slot 2   s → w = Screenshot menu l → l = Lock screen
b → 3 = BT slot 3
b → c = Clear BT
```

### Magic Key (Right Thumb)
```
After typing a letter:  tap = repeat that letter
Otherwise:              tap = sticky shift
                        double-tap = caps word
                        hold = shift
```
