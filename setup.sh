#!/usr/bin/env bash

mkdir -p ~/.config/zathura ~/.cargo
cp -r bat ~/.config/
cp -r picom ~/.config/
cp zathurarc ~/.config/zathura/
cp gitconfig ~/.gitconfig
cp xinitrc ~/.xinitrc
cp config.toml ~/.cargo/

# ./cargo.sh

echo "Finished."
