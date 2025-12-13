# Layers Reference Sheet

## Layer Overview

| # | Name | Access | Purpose |
|---|------|--------|---------|
| 0 | Main | default | Letters, home row mods |
| 1 | Lower | hold left thumb | Numbers, symbols, brackets |
| 2 | Raise | hold right thumb | F-keys, navigation, media |
| 3 | Mouse | Raise+Z | Mouse control (auto-exit) |
| 4 | BT | Lower+Raise (tri-layer) | Bluetooth profiles |

---

## Layer 0: MAIN
```
╭───────┬───────┬───────┬───────┬───────┬───────╮ ╭───────┬───────┬───────┬───────┬───────┬───────╮
│   `   │   Q   │   W   │   E   │   R   │   T   │ │   Y   │   U   │   I   │   O   │  ;/:  │ CAPS  │
├───────┼───────┼───────┼───────┼───────┼───────┤ ├───────┼───────┼───────┼───────┼───────┼───────┤
│  ESC  │   A   │   S   │   D   │   F   │   G   │ │   H   │   J   │   K   │   L   │   P   │   '   │
│       │ SHIFT │ CTRL  │  ALT  │  GUI  │ HYPER │ │ HYPER │  GUI  │  ALT  │ CTRL  │ SHIFT │       │
├───────┼───────┼───────┼───────┼───────┼───────┤ ├───────┼───────┼───────┼───────┼───────┼───────┤
│ SH/⌘  │   Z   │   X   │   C   │   V   │   B   │ │   N   │   M   │   ,   │   .   │   /   │ ENTER │
╰───────┴───────┴───────┼───────┼───────┼───────┤ ├───────┼───────┼───────┼───────┴───────┴───────╯
                        │  TAB  │ LOWER │ SPACE │ │BSP/DEL│ RAISE │ MAGIC │
                        ╰───────┴───────┴───────╯ ╰───────┴───────┴───────╯
```
**Notes:**
- Home row mods: hold for modifier, tap for letter
- HYPER = Shift+Ctrl+Alt+Gui (for app shortcuts)
- ;/: = tap for semicolon, double-tap for colon
- SH/⌘ = tap for Shift, double-tap for sticky Gui
- BSP/DEL = tap for backspace, shift+tap for delete
- MAGIC = tap for smart shift, hold for shift

---

## Layer 1: LOWER (Numbers & Symbols)
```
╭───────┬───────┬───────┬───────┬───────┬───────╮ ╭───────┬───────┬───────┬───────┬───────┬───────╮
│       │   1   │   2   │   3   │   4   │   5   │ │   6   │   7   │   8   │   9   │   0   │       │
├───────┼───────┼───────┼───────┼───────┼───────┤ ├───────┼───────┼───────┼───────┼───────┼───────┤
│       │   -   │   =   │   [   │   ]   │   \   │ │   _   │   +   │   {   │   }   │   |   │       │
│       │ SHIFT │ CTRL  │  ALT  │  GUI  │ HYPER │ │ HYPER │  GUI  │  ALT  │ CTRL  │ SHIFT │       │
├───────┼───────┼───────┼───────┼───────┼───────┤ ├───────┼───────┼───────┼───────┼───────┼───────┤
│       │ ⌃←    │ ⌃⇧TAB │  ⌘Z   │ ⌃TAB  │  ⌃→   │ │SWAPPER│ ⇧TAB  │   (   │   )   │       │       │
╰───────┴───────┴───────┼───────┼───────┼───────┤ ├───────┼───────┼───────┼───────┴───────┴───────╯
                        │ (TAB) │→MAIN  │(SPACE)│ │(BSPC) │→MAIN  │(MAGIC)│
                        ╰───────┴───────┴───────╯ ╰───────┴───────┴───────╯
```
**Notes:**
- Numbers on top row
- Symbols on home row with HRM
- Navigation helpers on bottom (word jump, tab cycling, undo)
- SWAPPER = Cmd+Tab window switcher (tap to cycle, release to select)
- (parentheses) = transparent, passes through to Main layer

---

## Layer 2: RAISE (F-keys, Nav, Media)
```
╭───────┬───────┬───────┬───────┬───────┬───────╮ ╭───────┬───────┬───────┬───────┬───────┬───────╮
│  F1   │  F2   │  F3   │  F4   │  F5   │  F6   │ │  F7   │  F8   │  F9   │  F10  │  F11  │  F12  │
├───────┼───────┼───────┼───────┼───────┼───────┤ ├───────┼───────┼───────┼───────┼───────┼───────┤
│       │  ⌘X   │  ⌘C   │ PgUp  │  ⌘V   │  ⌘+   │ │   ←   │   ↓   │   ↑   │   →   │ SHIFT │  ⏭⏮  │
│       │ SHIFT │ CTRL  │  ALT  │  GUI  │ HYPER │ │ HYPER │  GUI  │  ALT  │ CTRL  │       │       │
├───────┼───────┼───────┼───────┼───────┼───────┤ ├───────┼───────┼───────┼───────┼───────┼───────┤
│       │ MOUSE │ Home  │ PgDn  │  End  │  ⌘-   │ │LEADER │  🔇   │  🔉   │  🔊   │  ⏯   │       │
╰───────┴───────┴───────┼───────┼───────┼───────┤ ├───────┼───────┼───────┼───────┴───────┴───────╯
                        │ (TAB) │→MAIN  │(SPACE)│ │(BSPC) │→MAIN  │(MAGIC)│
                        ╰───────┴───────┴───────╯ ╰───────┴───────┴───────╯
```
**Notes:**
- F-keys on top row
- Arrow keys on right home row (Vim-style HJKL)
- Cut/Copy/Paste on left home with HRM
- Zoom in/out (⌘+/⌘-)
- MOUSE = activates mouse layer (auto-exits when done)
- LEADER = starts leader key sequence
- ⏭⏮ = tap for next track, shift+tap for previous

---

## Layer 3: MOUSE
```
╭───────┬───────┬───────┬───────┬───────┬───────╮ ╭───────┬───────┬───────┬───────┬───────┬───────╮
│       │       │ Scr↑  │  M↑   │ Scr↓  │       │ │       │ Scr←  │ Scr↓  │ Scr↑  │ Scr→  │       │
├───────┼───────┼───────┼───────┼───────┼───────┤ ├───────┼───────┼───────┼───────┼───────┼───────┤
│       │ SHIFT │  M←   │  M↓   │  M→   │       │ │       │ LClk  │ MClk  │ RClk  │ SHIFT │       │
├───────┼───────┼───────┼───────┼───────┼───────┤ ├───────┼───────┼───────┼───────┼───────┼───────┤
│       │ CTRL  │  ALT  │  GUI  │       │       │ │       │       │  GUI  │  ALT  │ CTRL  │       │
╰───────┴───────┴───────┼───────┼───────┼───────┤ ├───────┼───────┼───────┼───────┴───────┴───────╯
                        │→MAIN  │→MAIN  │ LClk  │ │ RClk  │→MAIN  │→MAIN  │
                        ╰───────┴───────┴───────╯ ╰───────┴───────┴───────╯
```
**Notes:**
- WASD-style mouse movement on left hand
- Scroll wheel on Q and E positions
- Mouse clicks on right hand home row
- Modifiers available for Cmd+Click, etc.
- **AUTO-EXIT:** Layer deactivates when you press any non-mouse key!

---

## Layer 4: BT (Bluetooth)
```
╭───────┬───────┬───────┬───────┬───────┬───────╮ ╭───────┬───────┬───────┬───────┬───────┬───────╮
│       │  BT0  │  BT1  │  BT2  │  BT3  │BT CLR │ │   7   │   8   │   9   │   -   │   *   │BSP/DEL│
├───────┼───────┼───────┼───────┼───────┼───────┤ ├───────┼───────┼───────┼───────┼───────┼───────┤
│       │       │       │       │       │       │ │   4   │   5   │   6   │   +   │       │       │
├───────┼───────┼───────┼───────┼───────┼───────┤ ├───────┼───────┼───────┼───────┼───────┼───────┤
│       │       │       │BL OFF │       │       │ │   1   │   2   │   3   │   /   │       │       │
╰───────┴───────┴───────┼───────┼───────┼───────┤ ├───────┼───────┼───────┼───────┴───────┴───────╯
                        │ (TAB) │→MAIN  │(SPACE)│ │(BSPC) │→MAIN  │(MAGIC)│
                        ╰───────┴───────┴───────╯ ╰───────┴───────┴───────╯
```
**Notes:**
- BT0-BT3 = Bluetooth profile selection
- BT CLR = Triple-tap to clear current profile (safety)
- Right side has numpad layout
- Access via: hold Lower + Raise simultaneously (tri-layer)
- Or: 4-corner combo (positions 0+1+10+11)
