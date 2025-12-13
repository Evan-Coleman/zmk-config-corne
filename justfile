# ZMK Firmware Build Commands
# Run `just --list` to see all available commands

# Default recipe
default:
    @just --list

# Initialize ZMK workspace (run once)
# This repo IS the workspace - zmk/, zephyr/, modules/ are created as siblings to config/
init:
    #!/usr/bin/env bash
    set -euo pipefail
    if [ ! -d "zmk" ]; then
        echo "Initializing west workspace..."
        west init -l config
        west update
        west zephyr-export
        echo "ZMK workspace initialized!"
        echo "Structure: zmk/, zephyr/, modules/ created alongside config/"
    else
        echo "ZMK already initialized. Run 'just update' to update."
    fi

# Update ZMK and modules
update:
    west update

# Build both halves
build: left right
    @echo "Build complete! Firmware files in .build/"

# Build left half
left:
    #!/usr/bin/env bash
    set -euo pipefail
    CONFIG_DIR="$(pwd)/config"
    BUILD_DIR="$(pwd)/.build"
    mkdir -p "$BUILD_DIR"
    west build -s zmk/app -d "$BUILD_DIR/left" -b nice_nano_v2 -- \
        -DSHIELD="corne_left nice_view_adapter nice_view" \
        -DZMK_CONFIG="$CONFIG_DIR" \
        -DSNIPPET="studio-rpc-usb-uart"
    cp "$BUILD_DIR/left/zephyr/zmk.uf2" "$BUILD_DIR/corne_left-nice_nano_v2.uf2"
    echo "Left half built: .build/corne_left-nice_nano_v2.uf2"

# Build right half
right:
    #!/usr/bin/env bash
    set -euo pipefail
    CONFIG_DIR="$(pwd)/config"
    BUILD_DIR="$(pwd)/.build"
    mkdir -p "$BUILD_DIR"
    west build -s zmk/app -d "$BUILD_DIR/right" -b nice_nano_v2 -- \
        -DSHIELD="corne_right nice_view_adapter nice_view" \
        -DZMK_CONFIG="$CONFIG_DIR"
    cp "$BUILD_DIR/right/zephyr/zmk.uf2" "$BUILD_DIR/corne_right-nice_nano_v2.uf2"
    echo "Right half built: .build/corne_right-nice_nano_v2.uf2"

# Clean build directory
clean:
    rm -rf .build
    echo "Build directory cleaned"

# Generate keymap visualization
draw:
    #!/usr/bin/env bash
    set -euo pipefail
    mkdir -p .build/keymap
    keymap parse -c 10 -z config/corne.keymap > .build/keymap/keymap.yaml
    keymap draw .build/keymap/keymap.yaml > .build/keymap/keymap.svg
    echo "Keymap visualization generated: .build/keymap/keymap.svg"

# Flash left half (put keyboard in bootloader mode first)
flash-left:
    #!/usr/bin/env bash
    set -euo pipefail
    # Find the mounted NICENANO drive
    DRIVE=$(ls -d /Volumes/NICENANO* 2>/dev/null | head -1)
    if [ -z "$DRIVE" ]; then
        echo "Error: No NICENANO drive found. Put keyboard in bootloader mode first."
        echo "Double-tap reset button on the nice!nano"
        exit 1
    fi
    cp .build/corne_left-nice_nano_v2.uf2 "$DRIVE/"
    echo "Flashed left half to $DRIVE"

# Flash right half (put keyboard in bootloader mode first)
flash-right:
    #!/usr/bin/env bash
    set -euo pipefail
    DRIVE=$(ls -d /Volumes/NICENANO* 2>/dev/null | head -1)
    if [ -z "$DRIVE" ]; then
        echo "Error: No NICENANO drive found. Put keyboard in bootloader mode first."
        echo "Double-tap reset button on the nice!nano"
        exit 1
    fi
    cp .build/corne_right-nice_nano_v2.uf2 "$DRIVE/"
    echo "Flashed right half to $DRIVE"

# Watch config for changes and rebuild
watch:
    #!/usr/bin/env bash
    echo "Watching config/ for changes..."
    fswatch -o config/ | while read; do
        echo "Change detected, rebuilding..."
        just build
    done
