# Adwaita Theme for GIMP 3: adw-gimp3

A complementary theme to `adw-gtk3` for perfect GIMP styling_

![Theme preview](preview-dark.png)

## Usage

> [!NOTE]
> If you have Nix installed, you can simply run:
>
> `nix run github:dp0sk/adw-gimp3`
>
> to launch a version of GIMP 3.0 with `adw-gimp3` built in.
> or:
>


## Installation

### Nix / NixOS

Use the provided modules to use `adw-gimp3` in your configs:

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    adw-gimp3.url = "github:dp0sk/adw-gimp3";
  };
  outputs = { nixpkgs, adw-gimp3, ... }@inputs: {
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

````

### Manual Installation

> [!NOTE]
> This theme depends on [`adw-gtk3`](https://github.com/lassekongo83/adw-gtk3) installation.
> Follow the instructions there before proceeding with `adw-gimp3` installation.

### Install `adw-gtk3`

`install.sh` will handle the flatpak configuration automatically.

1. Install the [adw-gtk3](https://github.com/lassekongo83/adw-gtk3) theme first.
2. Enable the `adw-gtk3` theme via one of the following:
  - GNOME Tweaks
  - [Refine](https://flathub.org/apps/page.tesk.Refine)
  <!-- - TODO: fix -->
  <!-- `gsettings set org.gnome.desktop gtk-theem adw-gtk3` -->

#### Configuring flatpak

Manually:

1. Install [Flatseal](https://flathub.org/apps/com.github.tchx84.Flatseal)
2. Navigate to `All applications (global) → Filesystem → Other files`
3. Add these lines: 	
   - `xdg-config/gtk-3.0:ro`
   - `xdg-config/gtk-4.0:ro`
4. Now all your flatpak apps will be themed!



> [!WARNING]
> Flatpak doesn’t apply your system themes by default. To enable them, follow these steps:

2. Download the `adw-gimp3` repository
3. Either:
   - Run `install.sh`, or
   - Manually copy the `adw-gimp3` folder to `~/.config/GIMP/3.0/themes/`
Launch GIMP and navigate to:
   `Edit → Preferences → Theme` → Select "adw-gimp3"
5. *(Optional)* For better integration:
   `Edit → Preferences → Image Windows` → Enable "Merge menu and title bar"
6. Done!

### Notes

- This theme depends on `adw-gtk3` installation
- Currently only dark theme is supported (Light theme will be added)
- Windows and macOS support is planned (Will be supported in future updates)

