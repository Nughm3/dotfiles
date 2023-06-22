# Arch Linux changes `hx` to `helix`
# alias hx="helix"

set -g fish_greeting
set -gx SHELL /run/current-system/sw/bin/fish
set -gx EDITOR hx
set -gx NEXT_TELEMETRY_DISABLED
set -gx ASTRO_TELEMETRY_DISABLED

fish_add_path ~/.local/bin
fish_add_path ~/.cargo/bin

alias rc="$EDITOR ~/.config/fish/config.fish"
alias so="source ~/.config/fish/config.fish"

alias nixos-config="sudoedit /etc/nixos/configuration.nix"
alias nixos-update="sudo nixos-rebuild switch --upgrade-all"
alias nixos-clean="sudo nix-collect-garbage -d"

alias e="$EDITOR"
alias c="cargo"

alias ls="exa --icons --git"
alias la="ls -la"
alias lt="ls -T --git-ignore"

alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -ir"
alias mkdir="mkdir -p"
alias md="mkdir"

alias py="python3 -q"
alias fd="fd -H"
alias watchexec="watchexec --clear=clear"
alias wx="watchexec"
alias zj="zellij"
alias at='zellij attach (zellij list-sessions | fzf -0 -1)'
alias ac='zellij attach --create (basename $PWD)'

alias g="git"
alias gs="git status"
alias gd="git diff"
alias gl="git log --oneline --graph"
alias gu="git pull"
alias gp="git push"
alias gg='cd (git rev-parse --show-toplevel)'
alias rt="git rev-parse --show-toplevel"

if status is-interactive
    zoxide init fish | source
    starship init fish | source
    direnv hook fish | source
    zellij setup --generate-completion fish | source
    # INHIBIT_THEME_HIST=1 theme.sh onedark
end
