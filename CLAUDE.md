# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a ZMK firmware configuration for a Corne (crkbd) split keyboard with nice!view displays, using nice_nano_v2 controllers.

## Build Commands

**GitHub Actions (recommended):** Push changes to trigger automatic builds via the nix workflow, or manually trigger via workflow_dispatch.

**Local build environment setup:**
```bash
west init -l config
west update
west zephyr-export
```

**Visualize keymap:** Use [keymap-editor](https://nickcoutsos.github.io/keymap-editor/) for graphical editing.

## Architecture

### Configuration Files (config/)

- `corne.keymap` - Main keymap file defining layers and behaviors
- `base.keymap` - Home row mod (HRM) definitions using zmk-helpers macros
- `corne.conf` - Keyboard settings (display, bluetooth, sleep, debounce)
- `mouse.dtsi` - Mouse emulation settings (pointing device config)
- `west.yml` - West manifest defining ZMK modules and dependencies

### Layers

0. **Main** - Base QWERTY with home row mods (Shift/Ctrl/Alt/GUI on home row)
1. **Lower** - Numbers, symbols, brackets
2. **Raise** - Function keys, navigation, media controls
3. **BT** - Bluetooth profile selection, numpad
4. **Nav** - Navigation and media

### Key Behaviors

- **Home Row Mods (HRM):** Defined in `base.keymap` using `hml` (left) and `hmr` (right) hold-taps with balanced flavor
- **Mod-morphs:** `bkspc_del` (backspace/delete), `back_forward` (next/prev track)
- **Tap-dances:** `bt_clear` (triple-tap to clear BT), `shift_win`, `caps_ptsc`, `tab_CAD_taskMan`
- **Combos:** BT layer access via 4-key corner combo

### ZMK Modules (via west.yml)

Uses urob's ZMK ecosystem pinned to v0.3:
- zmk-helpers (key position labels, macros)
- zmk-adaptive-key, zmk-auto-layer, zmk-leader-key, zmk-tri-state, zmk-unicode

### Hardware Config

- nice_nano_v2 controllers with nice_view displays
- ZMK Studio RPC enabled (`studio-rpc-usb-uart` snippet)
- BLE with +8dBm TX power and passkey pairing
- 30-minute sleep timeout
- Eager debouncing (1ms press, 7ms release)
