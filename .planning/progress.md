# ZMK Config Enhancement Progress

## Phase 1: Foundation ✓ Complete

- [x] Fix build errors (helper.h, QUICK_TAP_MS, 42.h key-labels)
- [x] Layer switching: triple-tap for sticky, otherwise hold
- [x] Replace right thumb ALT with Smart Shift
- [x] Add coding symbol combos (prioritized for Swift/JS/Java)
- [x] Add Caps Word combo (F+J) + configure continue-list
- [x] Build verified passing (GitHub Actions)

## Phase 2: Comfort Features

- [ ] Tri-layer setup (Lower+Raise = BT)
- [ ] Alt-Tab swapper
- [ ] ESC combo (W+E) - optional
- [ ] Backspace combo (I+O) - optional
- [ ] Enter combo (K+L) - optional

## Phase 3: Advanced Features

- [ ] Mouse layer with auto-toggle
- [ ] Leader key sequences
- [ ] Key repeat functionality (upgrade smart shift)
- [ ] Unicode characters

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
| **Tri-Layer** | Hold both thumbs = BT layer | Pending |
| **Swapper** | Single key Alt-Tab cycling | Pending |
| **Mouse Layer** | WASD mouse control | Pending |
| **Leader Key** | Vim-style command sequences | Pending |

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
```
