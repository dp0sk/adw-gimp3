#!/usr/bin/env bash

echo 'Installing adw-gimp3...'

if command -v gimp >/dev/null; then
  echo '[system] copying theme...'
  mkdir -p ~/.config/GIMP/3.0/themes
  cp -Rv adw-gimp3 ~/.config/GIMP/3.0/themes/

  if command -v flatpak >/dev/null; then
    if [[ -d "$HOME/.var/app/org.gimp.GIMP" ]]; then
      echo -n '[flatpak-user:org.gimp.GIMP] creating override...'
      flatpak override --user --filesystem=xdg-config/GIMP/3.0/themes/adw-gimp3:ro org.gimp.GIMP && echo 'done.'
    fi

    if [[ -d "$HOME/.var/app/org.gimp.GIMP.Nightly" ]]; then
      echo -n '[flatpak-user:org.gimp.GIMP.Nightly] creating override...'
      flatpak override --user --filesystem=xdg-config/GIMP/3.0/themes/adw-gimp3:ro org.gimp.GIMP.Nightly && echo 'done.'
    fi
  fi

elif command -v flatpak >/dev/null; then
  echo '[system] no system GIMP installation found.'
  echo '[flatpak] installing for flatpak GIMP installations...'
  if [[ -d "$HOME/.var/app/org.gimp.GIMP" ]]; then
    echo '[flatpak:org.gimp.GIMP] copying theme...'
    mkdir -p ~/.var/app/org.gimp.GIMP/config/GIMP/3.0/themes/
    cp -Rv adw-gimp3 ~/.var/app/org.gimp.GIMP/config/GIMP/3.0/themes/
  fi
  if [[ -d "$HOME/.var/app/org.gimp.GIMP.Nightly" ]]; then
    echo '[flatpak:org.gimp.GIMP.Nightly] copying theme...'
    mkdir -p ~/.var/app/org.gimp.GIMP.Nightly/config/GIMP/3.0/themes/
    cp -Rv adw-gimp3 ~/.var/app/org.gimp.GIMP.Nightly/config/GIMP/3.0/themes/
  fi
fi

echo '[flatpak] installing adw-gtk3 GTK3 theme for flatpaks...'
if command -v flatpak >/dev/null; then
  flatpak install --assumeyes --noninteractive org.gtk.Gtk3theme.adw-gtk3 org.gtk.Gtk3theme.adw-gtk3-dark
fi
