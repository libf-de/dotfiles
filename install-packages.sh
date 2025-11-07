#!/bin/bash

if [[ "$OSTYPE" == "darwin"* ]]; then
  brew install zoxide fzf stow
  exit 0
fi

# Don't link Library on Linux
grep Library .stow-local-ignore >/dev/null || echo "Library" >> .stow-local-ignore

sudo apt install stow i3 polybar rofi picom alttab brightnessctl pamixer feh zoxide fzf xscreensaver

echo "Run \"stow .\" in this (dotfiles) folder!"
