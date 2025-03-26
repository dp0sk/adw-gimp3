# Adwaita Theme for GIMP 3: adw-gimp3

A complementary theme to `adw-gtk3` for perfect GIMP styling.

> [!NOTE]
> Currently, only dark theme is officially supported (Light theme will be added later)
> Windows & macOS support is planned (Will be supported in future updates)

![Theme preview](preview-dark.png)


## Usage

> [!NOTE]
> If you have Nix installed, you can simply run:
>
> `nix run github:dp0sk/adw-gimp3`
>
> to launch a version of GIMP 3.0 with `adw-gimp3` built in.


## Installation

> [!NOTE]
> This theme depends on [`adw-gtk3`](https://github.com/lassekongo83/adw-gtk3) installation,
> for non-NixOS systems.
> Follow the instructions there before proceeding with `adw-gimp3` installation.

### Manual Installation

#### adw-gtk3

1. Install the [adw-gtk3](https://github.com/lassekongo83/adw-gtk3) theme first.

2. Enable the `adw-gtk3` theme via one of the following:

  - GNOME Tweaks
  - [Refine](https://flathub.org/apps/page.tesk.Refine)
  - Run: `gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3'`


#### adw-gimp3

1. Download the `adw-gimp3` repository

    ```bash
    git clone https://github.com/dp0sk/adw-gimp3
    cd adw-gimp3
    ```

2. Install the theme to your config directory by either running the installation script (`install.sh`) **OR** manually copying the `adw-gimp3` folder to `~/.config/GIMP/3.0/themes/`:

    ```bash
    mkdir -p ~/.config/GIMP/3.0/themes
    cp -r adw-gimp3 ~/.config/GIMP/3.0/themes
    ```

3. Launch GIMP
4. Navigate to `Edit → Preferences → Theme`
5. Select the `adw-gimp3` theme.
6. *(Optional)* For better integration, navigate to: `Edit → Preferences → Image Windows`
7. *(Optional)* Enable `"Merge menu and title bar"`
8. Done!

#### Configuring flatpak

> [!NOTE]
> `install.sh` will handle the flatpak configuration automatically.

> [!WARNING]
> Flatpak doesn’t apply your system themes by default. To enable them, follow these steps:

1. Install [Flatseal](https://flathub.org/apps/com.github.tchx84.Flatseal)
2. Navigate to `All applications (global) → Filesystem → Other files`
3. Add these lines: 	
   - `xdg-config/gtk-3.0:ro`
   - `xdg-config/gtk-4.0:ro`
4. Now all your flatpak apps will be themed!


### Nix / NixOS

[NixOS](https://nixos.org),
[nix-darwin](https://github.com/LnL7/nix-darwin), &
[home-manager](https://github.com/nix-community/home-manager)
users can use the provided modules to install GIMP pre-loaded with the `adw-gimp3` theme in your environment configs:

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nix-darwin.url = "github:LnL7/nix-darwin/nix-darwin-24.11"
    home-manager.url = "github:nix-community/home-manager";
    adw-gimp3.url = "github:dp0sk/adw-gimp3";
  };
  outputs = inputs@{ nixpkgs, nix-darwin, adw-gimp3, ... }: {
    # Install system-wide on a nix-darwin system:
    darwinConfigurations."Johns-Macbook" = nix-darwin.lib.darwinSystem {
      modules = [adw-gimp3.darwinModules.default];
    };

    # Install system-wide on a NixOS system:
    nixosConfigurations.my-host = nixpkgs.lib.nixosSystem {
      modules = [adw-gimp3.nixosModules.default];
    };

    # Install in your user home environment:
    homeConfigurations.my-home = home-manager.lib.homeConfiguration {
      modules = [adw-gimp3.homeManagerModules.default];
    };
  };
}
```

or install GIMP 3.0 with `adw-gimp3` to a profile:

```bash
nix profile install github:dp0sk/adw-gimp3`
```

