#!/bin/sh

xrandr --output HDMI-1 --same-as eDP-1 &
nitrogen --restore &

picom --daemon &
sxhkd &
dunst &

exec dwm
