# Keymap Visual Reference

## Layer Overview

| Layer | # | Access | Purpose |
|-------|---|--------|---------|
| Main | 0 | Default | Letters, HRM, base typing |
| Lower | 1 | Left thumb hold | Numbers, symbols, nav shortcuts |
| Raise | 2 | Right thumb hold | F-keys, arrows, media, tools |
| BT | 3 | Lower+Raise (tri-layer) | Bluetooth, numpad |
| Nav | 4 | Corner combo or from BT | Navigation, media |
| Mouse | 5 | Raise+Z (smart mouse) | WASD mouse control |

---

## Layer 0: Main (Base QWERTY + Home Row Mods)

```
╭───────┬───────┬───────┬───────┬───────┬───────╮   ╭───────┬───────┬───────┬───────┬───────┬───────╮
│   `   │   Q   │   W   │   E   │   R   │   T   │   │   Y   │   U   │   I   │   O   │   ;   │ CAPS  │
├───────┼───────┼───────┼───────┼───────┼───────┤   ├───────┼───────┼───────┼───────┼───────┼───────┤
│  ESC  │   A   │   S   │   D   │   F   │   G   │   │   H   │   J   │   K   │   L   │   P   │   '   │
│       │ SHFT  │ CTRL  │  ALT  │  GUI  │ HYPER │   │ HYPER │  GUI  │  ALT  │ CTRL  │ SHFT  │       │
├───────┼───────┼───────┼───────┼───────┼───────┤   ├───────┼───────┼───────┼───────┼───────┼───────┤
│ SHFT  │   Z   │   X   │   C   │   V   │   B   │   │   N   │   M   │   ,   │   .   │   /   │ ENTER │
│ 2tap=⌘│       │       │       │       │       │   │       │       │       │       │       │       │
╰───────┴───────┴───────┼───────┼───────┼───────┤   ├───────┼───────┼───────┼───────┴───────┴───────╯
                        │  TAB  │ LOWER │ SPACE │   │ BSPC  │ RAISE │ MAGIC │
                        │       │3tap=▼1│       │   │ ⇧=DEL │3tap=▼2│repeat │
                        ╰───────┴───────┴───────╯   ╰───────┴───────┴───────╯

Home Row Mods: Hold letter = modifier (SHFT/CTRL/ALT/GUI)
HYPER = Shift+Ctrl+Alt+Gui (for custom shortcuts)
```

---

## Layer 1: Lower (Numbers + Symbols)

```
╭───────┬───────┬───────┬───────┬───────┬───────╮   ╭───────┬───────┬───────┬───────┬───────┬───────╮
│       │   1   │   2   │   3   │   4   │   5   │   │   6   │   7   │   8   │   9   │   0   │       │
├───────┼───────┼───────┼───────┼───────┼───────┤   ├───────┼───────┼───────┼───────┼───────┼───────┤
│       │   -   │   =   │   [   │   ]   │   \   │   │   _   │   +   │   {   │   }   │   |   │       │
│       │ SHFT  │ CTRL  │  ALT  │  GUI  │ HYPER │   │ HYPER │  GUI  │  ALT  │ CTRL  │ SHFT  │       │
├───────┼───────┼───────┼───────┼───────┼───────┤   ├───────┼───────┼───────┼───────┼───────┼───────┤
│       │ ←Word │ ←Tab  │  ⌘Z   │ Tab→  │ Word→ │   │ SWAP  │ ⇧Tab  │   (   │   )   │       │       │
│       │       │       │ undo  │       │       │   │ ⌘Tab  │ rev   │       │       │       │       │
╰───────┴───────┴───────┼───────┼───────┼───────┤   ├───────┼───────┼───────┼───────┴───────┴───────╯
                        │       │ ▼ 0   │       │   │       │ ▼ 2   │       │
                        ╰───────┴───────┴───────╯   ╰───────┴───────┴───────╯

Symbol Logic: Left = base symbols, Right = shifted versions
Navigation: Word/tab navigation on bottom left
Swapper: Cmd-Tab window cycling (tap N, reverse with M)
```

---

## Layer 2: Raise (F-Keys + Navigation + Tools)

```
╭───────┬───────┬───────┬───────┬───────┬───────╮   ╭───────┬───────┬───────┬───────┬───────┬───────╮
│  F1   │  F2   │  F3   │  F4   │  F5   │  F6   │   │  F7   │  F8   │  F9   │  F10  │  F11  │  F12  │
├───────┼───────┼───────┼───────┼───────┼───────┤   ├───────┼───────┼───────┼───────┼───────┼───────┤
│       │  ⌘X   │  ⌘C   │ PgUp  │  ⌘V   │  ⌘+   │   │   ←   │   ↓   │   ↑   │   →   │ SHFT  │ ⏭/⏮  │
│       │ SHFT  │ CTRL  │  ALT  │  GUI  │ HYPER │   │ HYPER │  GUI  │  ALT  │ CTRL  │       │       │
├───────┼───────┼───────┼───────┼───────┼───────┤   ├───────┼───────┼───────┼───────┼───────┼───────┤
│       │ MOUSE │ Home  │ PgDn  │  End  │  ⌘-   │   │LEADER │  🔇   │  🔉   │  🔊   │  ⏯   │       │
│       │ smart │       │       │       │       │   │       │ mute  │ vol-  │ vol+  │ play  │       │
╰───────┴───────┴───────┼───────┼───────┼───────┤   ├───────┼───────┼───────┼───────┴───────┴───────╯
                        │       │ ▼ 1   │       │   │       │ ▼ 0   │       │
                        ╰───────┴───────┴───────╯   ╰───────┴───────┴───────╯

Clipboard: Cut/Copy/Paste on left home row
Navigation: Arrows on right, Page/Home/End on left
Media: Volume and playback on bottom right
Tools: Smart Mouse (Z), Leader key (N)
```

---

## Layer 3: BT (Bluetooth + Numpad)

```
╭───────┬───────┬───────┬───────┬───────┬───────╮   ╭───────┬───────┬───────┬───────┬───────┬───────╮
│       │ BT 0  │ BT 1  │ BT 2  │ BT 3  │BT CLR │   │   7   │   8   │   9   │   -   │   *   │ BSPC  │
│       │       │       │       │       │3tap   │   │       │       │       │       │       │       │
├───────┼───────┼───────┼───────┼───────┼───────┤   ├───────┼───────┼───────┼───────┼───────┼───────┤
│  ESC  │       │       │       │       │       │   │   4   │   5   │   6   │   +   │  ⌘L   │ PRTSC │
│       │       │       │       │       │       │   │       │       │       │       │ lock  │       │
├───────┼───────┼───────┼───────┼───────┼───────┤   ├───────┼───────┼───────┼───────┼───────┼───────┤
│ SHFT  │       │       │BL OFF │       │       │   │   1   │   2   │   3   │   /   │       │C-A-DEL│
│       │       │       │       │       │       │   │       │       │       │       │       │       │
╰───────┴───────┴───────┼───────┼───────┼───────┤   ├───────┼───────┼───────┼───────┴───────┴───────╯
                        │ CTRL  │ ▼ 0   │ SPACE │   │ ENTER │   0   │  ALT  │
                        ╰───────┴───────┴───────╯   ╰───────┴───────┴───────╯

Access: Hold Lower + Raise simultaneously (tri-layer)
        OR 4-corner combo (` Q ; CAPS)
```

---

## Layer 5: Mouse (WASD Control)

```
╭───────┬───────┬───────┬───────┬───────┬───────╮   ╭───────┬───────┬───────┬───────┬───────┬───────╮
│       │       │Scrl ↑ │  M↑   │Scrl ↓ │       │   │       │Scrl ← │Scrl ↓ │Scrl ↑ │Scrl → │       │
├───────┼───────┼───────┼───────┼───────┼───────┤   ├───────┼───────┼───────┼───────┼───────┼───────┤
│       │ SHFT  │  M←   │  M↓   │  M→   │       │   │       │ LEFT  │  MID  │ RIGHT │ SHFT  │       │
│       │       │       │       │       │       │   │       │ click │ click │ click │       │       │
├───────┼───────┼───────┼───────┼───────┼───────┤   ├───────┼───────┼───────┼───────┼───────┼───────┤
│       │ CTRL  │  ALT  │  GUI  │       │       │   │       │       │  GUI  │  ALT  │ CTRL  │       │
╰───────┴───────┴───────┼───────┼───────┼───────┤   ├───────┼───────┼───────┼───────┴───────┴───────╯
                        │ ▼ 0   │ ▼ 0   │ LEFT  │   │ RIGHT │ ▼ 0   │ ▼ 0   │
                        │       │       │ click │   │ click │       │       │
                        ╰───────┴───────┴───────╯   ╰───────┴───────┴───────╯

Access: Raise + Z (smart mouse - auto-deactivates on non-mouse key)
Movement: WASD style on left hand
Clicks: J/K/L on right hand (left/middle/right)
Modifiers: Available for drag operations
```

---

## Combos Quick Reference

### Symbols (Press both keys simultaneously)

```
VERTICAL (top + home):          HORIZONTAL (adjacent):
W+S = @    Y+H = ^              E+R = (    U+I = )
E+D = #    U+J = &              D+F = [    J+K = ]
R+F = $    I+K = *              C+V = {    ,+. = }
T+G = %                         R+T = <    Y+U = >

DIAGONAL (home + bottom):       SPECIAL:
D+C = ~    J+M = -              .+/ = =>  (arrow function)
F+V = \    K+, = _              F+J = Caps Word
           L+. = =
           P+/ = +
```

### Comfort Combos
```
W+E = ESC       (quick escape)
I+O = Backspace (quick delete)
K+L = Enter     (quick submit)
```

### System Combos
```
` Q ; CAPS = BT layer (4 corners)
```

---

## Special Behaviors

### Magic Key (Right Thumb)
| Context | Tap | Double-Tap | Hold |
|---------|-----|------------|------|
| After letter | Repeat letter | - | Shift |
| Otherwise | Sticky Shift | Caps Word | Shift |

### Layer Keys (Left/Right Thumb)
| Action | Lower | Raise |
|--------|-------|-------|
| Hold | Layer 1 | Layer 2 |
| Triple-tap | Toggle Layer 1 | Toggle Layer 2 |
| Both held | Layer 3 (BT) | - |

### Leader Key Sequences (Raise + N)
| Sequence | Action |
|----------|--------|
| b → 0/1/2/3 | Select BT slot |
| b → c | Clear BT |
| s → s | Full screenshot |
| s → a | Area screenshot |
| s → w | Screenshot menu |
| l → l | Lock screen |
| r → s → t | System reset |
| b → o → t | Bootloader |

### Cmd-Tab Swapper (Lower layer)
| Key | Action |
|-----|--------|
| N (position 30) | Start/continue Cmd-Tab |
| M (position 31) | Reverse (Shift-Tab) |
| Any other key | Confirm selection |

---

## Modifier Legend

| Symbol | Modifier |
|--------|----------|
| ⌘ | Command (GUI) |
| ⌥ | Option (Alt) |
| ⌃ | Control |
| ⇧ | Shift |
| HYPER | ⇧⌃⌥⌘ (all four) |

---

## Tips

1. **Home Row Mods**: Hold A/S/D/F for Shift/Ctrl/Alt/Cmd
2. **Quick symbols**: Use combos instead of layer switching
3. **Double letters**: Type letter, tap magic key to repeat
4. **Window switching**: Lower + N to start, keep tapping to cycle
5. **Mouse mode**: Raise + Z, then WASD - auto-exits on any other key
6. **BT switching**: Hold both thumbs, or use leader: b → 0-3
