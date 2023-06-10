export PATH="$PATH:~/.local/bin:~/.cargo/bin:~/.fly/bin"
export EDITOR="hx"

export NEXT_TELEMETRY_DISABLED=1
export ASTRO_TELEMETRY_DISABLED=1

alias note='$EDITOR ~/Documents/notes/$(date +%Y-%m-%d).md'

alias nixos-config="sudoedit /etc/nixos/configuration.nix"
alias nixos-update="sudo nixos-rebuild switch --upgrade-all"
alias nixos-clean="sudo nix-collect-garbage -d"

alias rc='$EDITOR ~/.bashrc'
alias so="source ~/.bashrc"

alias ls="exa --icons --git"
alias la="exa --icons --git -la"
alias lt="exa -T --icons --git-ignore"

alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -ir"
alias mkdir="mkdir -p"
alias md="mkdir"

alias e='$EDITOR'
alias c="cargo"
alias py="python3 -q"
alias fd="fd -H"
alias watchexec="watchexec --clear=clear"
alias wx="watchexec"
alias zj="zellij"
alias at='zellij attach $(zellij list-sessions | fzf -0 -1)'
alias ac='zellij attach --create ${PWD##*/}'

alias g="git"
alias gs="git status"
alias gd="git diff"
alias gl="git log --oneline --graph"
alias gu="git pull"
alias gp="git push"
alias gg='cd $(git rev-parse --show-toplevel)'
alias rt="git rev-parse --show-toplevel"

if [[ -t 0 ]]; then
  eval "$(direnv hook bash)"
  eval "$(starship init bash)"
  eval "$(zoxide init bash)"

  if [[ -t $ZELLIJ ]]; then
    eval "$(zellij setup --generate-completion bash)"
  fi
fi
