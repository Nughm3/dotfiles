alias ls="exa"
alias la="exa -la"
alias cat="bat"
alias fd="fd -H"
alias tree="tree -C"

alias fishrc="nvim ~/.config/fish/config.fish"
alias refish="source ~/.config/fish/config.fish"

alias xmonadrc="nvim ~/.xmonad/xmonad.hs"
alias xmobarrc="nvim ~/.xmobarrc"
alias picomrc="nvim ~/.config/picom/picom.conf"

alias sedit="EDITOR=nvim sudoedit"
alias mkdirs="mkdir -p"

alias fm="xplr"

# Startup
export SUDO_EDITOR=nvim
clear
#pfetch
colorscript -r
starship init fish | source
