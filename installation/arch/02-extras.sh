#!/bin/bash

set -e

PKGS=(
  # Apps
  brave-bin
  calibre
  firefox
  git-extras
  mullvad-vpn
  seahorse
  thunderbird
  tldr

  # Fonts
  nerd-fonts-git
  noto-fonts
  ttf-fira-code
  ttf-material-design-icons-webfont
  ttf-roboto

  #https://wiki.archlinux.org/title/GNOME
  #https://archlinux.org/groups/x86_64/gnome/
  baobab
  cheese
  gnome-disk-utility
  gnome-font-viewer
  xdg-user-dirs-gtk

  #xfce
  thunar
  thunar-archive-plugin
  thunar-volman
  tumbler
)

for PKG in "${PKGS[@]}"; do
  echo
  echo "INSTALLING PACKAGE: $PKG"
  yay -S "$PKG" --noconfirm --needed
done

echo
echo "Installation is done"
echo
