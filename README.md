# dotfiles

Dotfiles (configuration files) I use on my Linux systems.

## Setup

```bash
git clone https://github.com/Nughm3/dotfiles ~/.dotfiles
cd ~/.dotfiles
stow home/
```

(use `stow -nv` to test run)

## NixOS

```bash
git clone https://github.com/Nughm3/dotfiles
cd dotfiles

nixos-generate-config --root /mnt
cp /mnt/etc/nixos/harware-configuration.nix ./nixos

nixos-install --flake .#nixos
reboot
```
