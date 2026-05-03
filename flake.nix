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
          version = "unstable";

          src = pkgs.fetchFromGitHub {
            owner = "alonso-herreros";
            repo = "hyprcap";
            rev = "main";
            hash = "sha256-qTlv4hRy9CvB+ZkNxXuxtLjDHsjiyjjooUlDFxwqQOc=";
          };

          nativeBuildInputs = [
            pkgs.makeWrapper
          ];

          buildInputs = [ ];

          installPhase = ''
            runHook preInstall

            mkdir -p $out/bin
            install -Dm755 hyprcap $out/bin/hyprcap

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
            description = "Screenshot and screen recording utility for Hyprland";
            homepage = "https://github.com/alonso-herreros/hyprcap";
            license = licenses.mit;
            platforms = platforms.linux;
          };
        };
      in {
        packages.default = hyprcap;

        devShells.default = pkgs.mkShell {
          buildInputs = [
            hyprcap
          ];
        };
      });
}
