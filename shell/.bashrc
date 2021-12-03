#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

export EDITOR=nvim
export SUDO_EDITOR=nvim
export PATH="/home/toxicfs/.local/bin/:/home/toxicfs/.cargo/bin/:/home/toxicfs/.emacs.d/bin/:/usr/local/bin/:/bin/:/usr/local/sbin/"

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi
