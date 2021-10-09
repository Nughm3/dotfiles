#!/usr/bin/env bash
kill dwmblocks &
kill picom &
kill sxhkd &
kill noisetorch &
killall pasystray &
xrandr --output HDMI-1 --same-as eDP-1 &
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
