#!/usr/bin/env bash
xrandr --output HDMI-1 --same-as eDP-1 &
killall dwmblocks &
killall picom &
killall sxhkd &
killall noisetorch &
killall pasystray &
discord &
asusctl -c 96 &
picom &
nitrogen --restore &
# nitrogen --no-recurse --random --set-scaled /usr/share/backgrounds/ &
sxhkd &
light-locker &
thunar --daemon &
noisetorch -i 95
pasystray &
play-with-mpv &
dwmblocks &
/usr/bin/emacs --daemon
