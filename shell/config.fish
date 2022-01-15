#!/bin/sh
alias ls="exa --icons --git-ignore"
alias la="exa -la --icons --git-ignore"
alias cat="bat"
alias fd="fd -H"
alias tree="tree -C"
alias gs="git st"
alias clear="clear && colorscript -r"
alias tree="exa -T"
alias op="fzf | xargs nvim"
alias cp="cp -r"

alias fishrc="nvim ~/.config/fish/config.fish"
alias picomrc="nvim ~/.config/picom/picom.conf"
alias refish="source ~/.config/fish/config.fish"

alias sedit="EDITOR=nvim sudoedit"
alias mkdirs="mkdir -p"

export SUDO_EDITOR=nvim
set fish_greeting
set EDITOR nvim
# set PATH $PATH:/home/toxicfs/.local/bin:/home/toxicfs/.cargo/bin/:/home/toxicfs/.emacs.d/bin/
export _ZO_FZF_OPTS="--height 40"
set CARGO_FORCE_WARN true
set CARGO_EDITOR nvim
set -Ux FZF_DEFAULT_OPTS "--preview 'bat {}' --color=fg:#c8ccd4,bg:#282c34,hl:#c678dd --color=fg+:#c8ccd4,bg+:#3e4451,hl+:#c678dd --color=info:#d19a66,prompt:#98c379,pointer:#e06c75 --color=marker:#e06c75,spinner:#d19a66,header:#61afef"
if status is-interactive
    clear
    zoxide init fish | source
    starship init fish | source
end
