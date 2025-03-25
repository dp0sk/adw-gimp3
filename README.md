# Adwaita Theme for GIMP 3: adw-gimp3

_A complementary theme to adw-gtk3 for perfect GIMP styling_

### ⚠️ FLATPAK WARNING ⚠️
Flatpak doesn’t apply your system themes by default. To enable them, follow these steps:

1. Install [Flatseal](https://flathub.org/apps/com.github.tchx84.Flatseal)
2. Navigate to `All applications (global) → Filesystem → Other files`
3. Add these lines: 	
   - `~/.config/gtk-3.0`
   - `~/.config/gtk-3.0:ro`
   - `~/.config/gtk-4.0`
   - `~/.config/gtk-4.0:ro`
   - `~/.themes`
   - `~/.themes:ro`
   - `xdg-config/gtk-3.0:ro`
   - `xdg-config/gtk-3.0`
   - `xdg-config/gtk-4.0:ro`
   - `xdg-config/gtk-4.0`
4. Now all your flatpak apps will be themed!

### Installation

1. Install the [adw-gtk3](https://github.com/lassekongo83/adw-gtk3) theme first and enable it in Gnome Tweaks or [Refine](https://flathub.org/apps/page.tesk.Refine)
2. Download the adw-gimp3 repository
3. Either:
   - Run `install.sh`, or
   - Manually copy the `adw-gimp3` folder to `~/.config/GIMP/3.0/themes/`
Launch GIMP and navigate to:
   `Edit → Preferences → Theme` → Select "adw-gimp3"
5. *(Optional)* For better integration:
   `Edit → Preferences → Image Windows` → Enable "Merge menu and title bar"
6. Done!

### Notes
- This theme depends on adw-gtk3 installation
- Currently only dark theme is supported (Light theme will be added)
- Windows and macOS support is planned (Will be supported in future updates)

### Screenshot
![Theme preview](preview-dark.png)
