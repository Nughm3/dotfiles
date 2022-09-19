set fish_greeting

export PATH="$PATH:~/.local/bin:~/.cargo/bin"
export EDITOR="helix"

alias e="$EDITOR"
alias c="cargo"

alias g="git"
alias gs="git status"
alias gd="git diff"
alias gp="git push"
alias gu="git pull"
alias gl="git log --oneline --graph"
alias gg='cd $(git rev-parse --show-toplevel)'

alias ls="exa --icons"
alias la="exa --icons --la --git"

alias cp="cp -r"
alias mkdir="mkdir -p"
alias md="mkdir"

alias fd="fd -H"

if status is-interactive
    zoxide init fish | source
    starship init fish | source
end
