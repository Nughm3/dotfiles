#!/bin/sh
alias ls="exa --icons --git-ignore"
alias la="exa -la --icons --git-ignore"
alias cat="bat"
alias fd="fd -H"
alias tree="tree -C"
alias gs="git st"
alias clear="clear && colorscript -r"
alias tree="exa -T"

alias fishrc="nvim ~/.config/fish/config.fish"
alias picomrc="nvim ~/.config/picom/picom.conf"
alias refish="source ~/.config/fish/config.fish"

alias sedit="EDITOR=nvim sudoedit"
alias mkdirs="mkdir -p"

export SUDO_EDITOR=nvim
set fish_greeting
set EDITOR nvim
set PATH /usr/local/sbin:/usr/local/bin:/usr/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl/:/home/toxicfs/.local/bin:/home/toxicfs/.cargo/bin/
if status is-interactive
    clear
    starship init fish | source
end
