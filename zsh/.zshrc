export XDG_CONFIG_HOME="$HOME/.config"

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi

export EDITOR="hx"
export PATH="$PATH:$HOME/.local/bin:$HOME/.cargo/bin"

autoload -U colors && colors
export PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

alias reload="source $HOME/.zshrc"
alias zshrc="$EDITOR $HOME/.zshrc"

alias e="$EDITOR"
alias c="cargo"
alias sudo="doas"

alias g="git"
alias gp="git push"
alias gu="git pull"
alias gl="git lg"
alias gd="git diff"
alias gs="git status"

alias ls="exa --icons"
alias la="exa -la --icons --git"
alias fd="fd -H"
alias md="mkdir"
alias cp="cp -r"

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^[[1;2C" forward-word
bindkey "^[[1;2D" backward-word

source ~/.zsh-syntax/zsh-syntax-highlighting.zsh
source ~/.zsh-autopair/autopair.zsh
autopair-init

theme.sh one-half-black
eval "$(zoxide init zsh)"
stty sane
