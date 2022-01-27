alias ls="exa --icons"
alias la="exa -la --icons"
alias cat="bat"
alias fd="fd -H"
alias tree="tree -C"
alias gs="git st"
alias tree="exa -T"
alias op="fzf | xargs nvim"
alias cp="cp -r"
alias clear="clear && neofetch"

alias refish="source ~/.config/fish/config.fish"

export SUDO_EDITOR=nvim
set fish_greeting
set EDITOR nvim
export _ZO_FZF_OPTS="--height 40"
set CARGO_FORCE_WARN true
set -Ux FZF_DEFAULT_OPTS "--preview 'bat {}' --color=fg:#c8ccd4,bg:#282c34,hl:#c678dd --color=fg+:#c8ccd4,bg+:#3e4451,hl+:#c678dd --color=info:#d19a66,prompt:#98c379,pointer:#e06c75 --color=marker:#e06c75,spinner:#d19a66,header:#61afef"
if status is-interactive
    #theme.sh onedark
    clear
    zoxide init fish | source
    starship init fish | source
end
