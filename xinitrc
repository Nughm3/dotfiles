xrandr --output HDMI-A-0 --same-as eDP &
nitrogen --restore &
pulseaudio --daemonize &
picom --daemon &
sxhkd &
~/.local/bin/blocks.sh &
exec dwm
