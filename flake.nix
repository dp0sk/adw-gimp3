{
  description = "Flake for adw-gimp3 theme.";
  inputs = {
    # Temporarily use nixpkgs fork until GIMP 3.0 is merged upstream
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:jtojnar/nixpkgs/gimp-meson";
    flake-parts.url = "github:hercules-ci/flake-parts";
    wrapper-manager = {
      url = "github:viperML/wrapper-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs @ {self, ...}:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin"];
      perSystem = {
        self',
        pkgs,
        ...
      }: {
        apps.default = self'.apps.gimp;
        apps.gimp = {
          meta.description = "GIMP 3.0 with Adwaita theme";
          type = "app";
          program = "${self'.packages.gimp}/bin/gimp";
        };
        apps.set-theme = {
          meta.description = "GIMP 3.0 with Adwaita theme";
          type = "app";
          program = pkgs.writeShellApplication {
            name = "set-gtk3-theme";
            runtimeInputs = with pkgs; [adw-gtk3];
            text = ''
              scheme="'$1'"
              gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3' && \
              if [[ $# -gt 0 ]]; then
                gsettings set org.gnome.desktop.interface color-scheme $scheme
              fi
            '';
          };
        };
        devShells.default = pkgs.mkShell {
          name = "adw-gimp3";
          packages = with pkgs; [
            adw-gtk3
          ];
          inputsFrom = with pkgs; [
            gimp-with-plugins
            self'.packages.gimp
          ];
        };
        packages.default = self'.packages.gimp;
        packages.adw-gimp3 = pkgs.stdenv.mkDerivation {
          name = "adw-gimp3";
          version = "2025-03-25";
          src = ./.;
          installPhase = ''
            mkdir -p $out
            cp -Rv $src/adw-gimp3/* $out
          '';
        };
        packages.gimp = inputs.wrapper-manager.lib.build {
          inherit pkgs;
          modules = [
            {
              wrappers.adw-gimp3 = let
                unwrapped = pkgs.symlinkJoin {
                  name = "gimp";
                  paths = [
                    pkgs.adw-gtk3
                    pkgs.gimp-with-plugins
                    (pkgs.stdenv.mkDerivation {
                      name = "adw-gimp3";
                      version = "2025-03-25";
                      src = ./.;
                      installPhase = ''
                        mkdir -p $out/share/gimp/3.0/themes/Adwaita
                        cp -Rv $src/adw-gimp3/* $out/share/gimp/3.0/themes/Adwaita
                      '';
                    })
                  ];
                };
                gimprc = pkgs.writeText "gimprc" ''
                  (theme-path "''${gimp_dir}/themes:''${gimp_data_dir}/themes:${unwrapped.outPath}/share/gimp/3.0/themes")
                  (theme "Adwaita")
                  (custom-title-bar yes)
                '';
              in {
                basePackage = unwrapped;
                prependFlags = ["--system-gimprc" gimprc];
              };
            }
          ];
        };
      };
      flake.darwinModules.default = {pkgs, ...}: {
        environment.systemPackages = with pkgs; [
          self'.packages.gimp
          adw-gtk3
        ];
      };
      flake.nixosModules.default = {pkgs, ...}: {
        environment.systemPackages = with pkgs; [
          self'.packages.gimp
          adw-gtk3
        ];
      };
      flake.homeManagerModules.default = {pkgs, ...}: {
        gtk.theme = {
          package = pkgs.adw-gtk3;
          name = "adw-gtk3";
        };
        home.packages = [self.packages.${pkgs.system}.gimp];
      };
    };
}
