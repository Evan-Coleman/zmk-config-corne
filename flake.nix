{
  description = "ZMK firmware build environment for Corne keyboard";

  inputs = {
    # Pin to 24.05 - nixos-unstable removed clang-tools_17 which zephyr-nix needs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";

    # ZMK firmware and modules
    zephyr = {
      url = "github:zmkfirmware/zephyr/v3.5.0+zmk-fixes";
      flake = false;
    };
    zephyr-nix = {
      url = "github:urob/zephyr-nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.zephyr.follows = "zephyr";
    };
  };

  outputs = { self, nixpkgs, zephyr-nix, ... }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      devShells = forAllSystems (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          zephyr = zephyr-nix.packages.${system};
        in
        {
          default = pkgs.mkShell {
            packages = [
              # Python and Zephyr SDK
              (zephyr.pythonEnv)
              (zephyr.sdk.override { targets = [ "arm-zephyr-eabi" ]; })

              # Build tools
              pkgs.cmake
              pkgs.dtc
              pkgs.gcc
              pkgs.ninja

              # Utilities
              pkgs.just
              pkgs.yq
            ];

            shellHook = ''
              export ZMK_BUILD_DIR="./.build"
              export ZMK_SRC_DIR="./zmk/app"
              echo "ZMK build environment ready!"
              echo ""
              echo "Commands:"
              echo "  just init     - Initialize ZMK source (first time)"
              echo "  just build    - Build firmware for both halves"
              echo "  just left     - Build left half only"
              echo "  just right    - Build right half only"
              echo "  just clean    - Clean build directory"
              echo ""
              echo "Optional: pip install keymap-drawer (for visualization)"
            '';
          };
        }
      );
    };
}
