xrandr --output HDMI-A-0 --same-as eDP &
nitrogen --restore &
pulseaudio --daemonize &
picom --daemon &
sxhkd &
dwmblocks &
# nm-applet &
# pasystray &
noisetorch -i & 
exec dwm
