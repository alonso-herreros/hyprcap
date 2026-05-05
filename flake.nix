{
  description = "HyprCap - Hyprland screenshot and recording utility";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        hyprcap = pkgs.stdenv.mkDerivation {
          pname = "hyprcap";
          version = "latest";

          src = self;

          nativeBuildInputs = [
            pkgs.makeWrapper
          ];

          # upstream build system
          buildPhase = ''
            runHook preBuild
            make all
            runHook postBuild
          '';

          installPhase = ''
            runHook preInstall

            make install PREFIX=$out

            wrapProgram $out/bin/hyprcap \
              --prefix PATH : ${pkgs.lib.makeBinPath [
                pkgs.wf-recorder
                pkgs.grim
                pkgs.slurp
                pkgs.hyprland
                pkgs.jq
                pkgs.wl-clipboard
                pkgs.hyprpicker
                pkgs.libnotify
                pkgs.fuzzel
              ]}

            runHook postInstall
          '';

          meta = with pkgs.lib; {
            description = "Screenshot and recording utility for Hyprland";
            homepage = "https://github.com/alonso-herreros/hyprcap";
            license = licenses.mit;
            platforms = platforms.linux;
            mainProgram = "hyprcap";
          };
        };

      in {
        packages.default = hyprcap;

        devShells.default = pkgs.mkShell {
          packages = [ hyprcap ];
        };
      });
}
