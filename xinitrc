xrandr --output HDMI-A-0 --same-as eDP &
nitrogen --restore &

pulseaudio --start &
picom --daemon &
sxhkd &

exec dwm
