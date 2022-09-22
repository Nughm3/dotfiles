#!/usr/bin/env bash

mkdir -p ~/.cargo
cp -r bat ~/.config/
cp -r picom ~/.config/
cp gitconfig ~/.gitconfig
cp xinitrc ~/.xinitrc
cp config.toml ~/.cargo/

# cp zathurarc ~/.config/zathura/
# ./cargo.sh

echo "Finished."
