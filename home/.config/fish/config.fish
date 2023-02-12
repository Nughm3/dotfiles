#!/bin/fish

# Arch Linux changes `hx` to `helix`
alias hx="helix"

set -g fish_greeting
set -g ASTRO_TELEMETRY_DISABLE
set -g EDITOR hx
set -g PAGER bat

fish_add_path ~/.local/bin
fish_add_path ~/.cargo/bin

alias rc="$EDITOR ~/.config/fish/config.fish"
alias so="source ~/.config/fish/config.fish"

alias e="$EDITOR"
alias c="cargo"

alias g="git"
alias gs="git status"
alias gd="git diff"
alias gp="git push"
alias gu="git pull"
alias gl="git log --oneline --graph"
alias gg='cd (git rev-parse --show-toplevel)'

alias ls="exa --icons --git"
alias la="exa --icons -la --git"
alias lt="exa -T --icons --git-ignore"

alias cp="cp -r"
alias mkdir="mkdir -p"
alias md="mkdir"

alias fd="fd -H"
alias py="python3 -q"
alias pypy="pypy3 -q"

if status is-interactive
    zoxide init fish | source
    starship init fish | source
    INHIBIT_THEME_HIST=1 theme.sh onedark
end
