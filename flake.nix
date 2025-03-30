{
  description = "flake.nix";

  inputs = {
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixgl.url = "github:nix-community/nixGL";
  };

  outputs = { nixpkgs, nixgl, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ nixgl.overlay ];
      };
    in {
      devShells.x86_64-linux.default = pkgs.mkShell {
        nativeBuildInputs = with pkgs; [
          gcc
          gdb
          entr
          xorg.libX11.dev # <X11/Xlib.h>
          xorg.libXext.dev # <X11/extensions/Xshm.h>
          libnsl # ld: 找不到 -lnsl: No such file or directory
          xorg.xorgserver # need xephyr to run pseudo 256-color X11
        ];

        shellHook = ''
          cd linuxdoom-1.10
          echo "Nix env activated."
        '';
      };
    };
}
