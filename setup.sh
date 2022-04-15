#!/usr/bin/env bash
mkdir -p ~/.config/zathura ~/.cargo
cp -r bat ~/.config/
cp -r dunst ~/.config/
cp -r picom ~/.config/
cp -r rofi ~/.config/
cp zathurarc ~/.config/zathura/
cp gitconfig ~/.gitconfig
cp xinitrc ~/.xinitrc
cp zsh/* ~
cp config.toml ~/.cargo/

echo "Finished."
