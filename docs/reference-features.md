# Features & Behaviors Reference Sheet

---

## HOME ROW MODS (HRM)

Hold a home row key for the modifier, tap for the letter.

```
Left Hand:                          Right Hand:
┌───────┬───────┬───────┬───────┐   ┌───────┬───────┬───────┬───────┐
│   A   │   S   │   D   │   F   │   │   J   │   K   │   L   │   P   │
│ SHIFT │ CTRL  │  ALT  │  GUI  │   │  GUI  │  ALT  │ CTRL  │ SHIFT │
└───────┴───────┴───────┴───────┘   └───────┴───────┴───────┴───────┘

G and H also have HYPER (Shift+Ctrl+Alt+Gui) for app-specific shortcuts
```

**Timing:**
- Tapping term: 280ms
- Quick tap: 175ms (fast repeat doesn't trigger hold)
- Prior idle: 150ms (won't trigger hold if typing fast)

---

## SMART SHIFT (Magic Key - Right Thumb)

| Action | Result |
|--------|--------|
| **Tap** | Sticky Shift (next letter capitalized) |
| **Double-tap** | Caps Word mode |
| **Hold** | Regular Shift |
| **Tap after letter** | Repeat that letter |

### Caps Word Mode
- Automatically capitalizes until you press space or punctuation
- Continues on: `_` `-` `BACKSPACE` `DELETE`
- Perfect for: `CONSTANT_CASE`, `SCREAMING_SNAKE_CASE`
- Activate via: F+J combo OR double-tap Magic key

---

## LAYER ACCESS

### Momentary (Hold)
```
Hold left thumb (37)  → Lower layer (1)
Hold right thumb (40) → Raise layer (2)
```

### Toggle (Triple-tap)
```
Triple-tap left thumb  → Lock on Lower
Triple-tap right thumb → Lock on Raise
Tap either to return to Main
```

### Tri-Layer
```
Hold Lower + Raise simultaneously → BT layer (4)
```

### Special Access
```
Raise + Z → Mouse layer (3) with auto-exit
4-corner combo (0+1+10+11) → BT layer (4)
```

---

## SWAPPER (Cmd+Tab Window Switcher)

Located on Lower layer, N position (position 30).

| Action | Result |
|--------|--------|
| **First tap** | Activates Cmd+Tab, shows app switcher |
| **Keep tapping** | Cycles through apps |
| **Tap M (shift+tab)** | Reverse direction |
| **Press any other key** | Confirms selection, releases Cmd |

---

## LEADER KEY SEQUENCES

Located on Raise layer, N position (position 30).

Tap Leader, then type the sequence:

### Bluetooth
| Sequence | Action |
|----------|--------|
| `b` `0` | Select BT profile 0 |
| `b` `1` | Select BT profile 1 |
| `b` `2` | Select BT profile 2 |
| `b` `3` | Select BT profile 3 |
| `b` `c` | Clear current BT profile |

### Screenshots (macOS)
| Sequence | Action |
|----------|--------|
| `s` `s` | Full screenshot |
| `s` `a` | Area selection screenshot |
| `s` `w` | Screenshot menu (window select) |

### System
| Sequence | Action |
|----------|--------|
| `l` `l` | Lock screen (Cmd+Ctrl+Q) |
| `r` `s` `t` | System reset |
| `b` `o` `t` | Bootloader mode |

---

## TAP-DANCES

| Key | Tap | Double-Tap | Triple-Tap |
|-----|-----|------------|------------|
| **Semicolon** | `;` | `:` | - |
| **Lower thumb** | momentary | momentary | toggle lock |
| **Raise thumb** | momentary | momentary | toggle lock |
| **Left Shift** | Shift | Sticky Gui | - |
| **Caps key** | Caps Lock | Print Screen | - |
| **BT Clear** | nothing | nothing | Clear BT |

---

## MOD-MORPHS

| Key | Normal | With Shift |
|-----|--------|------------|
| **Backspace (right thumb)** | Backspace | Delete |
| **Next Track (Raise layer)** | Next Track | Previous Track |

---

## THUMB CLUSTER SUMMARY

```
╭─────────┬─────────┬─────────╮   ╭─────────┬─────────┬─────────╮
│   TAB   │  LOWER  │  SPACE  │   │ BSP/DEL │  RAISE  │  MAGIC  │
│         │ mo/lock │         │   │  morph  │ mo/lock │  smart  │
╰─────────┴─────────┴─────────╯   ╰─────────┴─────────┴─────────╯

On non-Main layers:
╭─────────┬─────────┬─────────╮   ╭─────────┬─────────┬─────────╮
│  (TAB)  │ →MAIN   │ (SPACE) │   │ (BSPC)  │ →MAIN   │ (MAGIC) │
│  trans  │ escape  │  trans  │   │  trans  │ escape  │  trans  │
╰─────────┴─────────┴─────────╯   ╰─────────┴─────────┴─────────╯
```

---

## QUICK TIPS

1. **Typing symbols fast:** Use combos instead of shift+number
2. **Java semicolons:** `;` is on main layer, no reach needed!
3. **Type annotations:** Double-tap `;` for `:`
4. **Constants:** F+J for Caps Word, then type `MY_CONSTANT`
5. **Logical operators:** G+H for `&&`, L+P for `||`
6. **Swift functions:** H+N for `->`, .+/ for `=>`
7. **Quick corrections:** I+O for backspace (no thumb needed)
8. **Submit/confirm:** K+L for Enter (no pinky stretch)
9. **Cancel/escape:** W+E for Escape (left hand only)
10. **Window switching:** Lower+N to start, keep tapping to cycle
