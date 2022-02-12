#!/usr/bin/env bash
#mkdir -p ~/.config/zathura ~/.config/fish ~/.cargo
mkdir -p ~/.config/zathura ~/.cargo
cp -r bat ~/.config/
cp -r dunst ~/.config/
cp -r picom ~/.config/
cp -r rofi ~/.config/
#cp starship.toml ~/.config/
#cp config.fish ~/.config/fish/
cp zathurarc ~/.config/zathura/
cp gitconfig ~/.gitconfig
cp xinitrc ~/.xinitrc

echo "Finished."
