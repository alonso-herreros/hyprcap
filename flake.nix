{
  description = "HyprCap - Hyprland screenshot and recording utility";

  inputs.nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz";

  outputs =
    { self, nixpkgs }:
    let
      eachSystem = nixpkgs.lib.genAttrs [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];
    in
    {
      packages = eachSystem (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          hyprcap = pkgs.callPackage (
            {
              lib,
              stdenv,
              makeBinaryWrapper,
              wf-recorder,
              grim,
              slurp,
              hyprland,
              jq,
              wl-clipboard,
              hyprpicker,
              libnotify,
              fuzzel,
            }:
            stdenv.mkDerivation {
              pname = "hyprcap";
              version = self.shortRev or "dirty";

              src = lib.cleanSource ./.;

              makeFlags = [ "PREFIX=${placeholder "out"}" ];

              nativeBuildInputs = [ makeBinaryWrapper ];

              postBuild = ''
                wrapProgram $out/bin/hyprcap \
                  --prefix "PATH" ":" "${
                    lib.makeBinPath [
                      wf-recorder
                      grim
                      slurp
                      hyprland
                      jq
                      wl-clipboard
                      hyprpicker
                      libnotify
                      fuzzel
                    ]
                  }"
              '';
              meta = {
                description = "Screenshot and recording utility for Hyprland";
                homepage = "https://github.com/alonso-herreros/hyprcap";
                license = lib.licenses.mit;
                platforms = lib.platforms.linux;
                mainProgram = "hyprcap";
              };
            }
          ) { };
          default = self.packages.${system}.hyprcap;
        }
      );
      devShells = eachSystem (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        pkgs.mkShell {
          inputsFrom = [ self.packages.${system}.hyprcap ];
          packages = with pkgs; [
            wf-recorder
            grim
            slurp
            hyprland
            jq
            wl-clipboard
            hyprpicker
            libnotify
            fuzzel
          ];
        }
      );
    };
}
