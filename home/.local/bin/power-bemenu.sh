#!/bin/sh

export BEMENU_OPTS="-i -p run --fn 'JetBrainsMono Nerd Font 11' -H 30 --ch 16 --cw 2 --hp 8 --tb '#61afef' --tf '#282c34' --ff '#c8ccd4' --fb '#1e222a' --nb '#282c34' --nf '#61afef' --hb '#61afef' --hf '#282c34' --ab '#282c34' --af '#61afef'"

case "$(echo -e "Shutdown\nRestart\nLogout\nSuspend\nLock" | bemenu -p 'power')" in
        Shutdown) exec systemctl poweroff;;
        Restart) exec systemctl reboot;;
        Logout) pkill dwm;;
        Suspend) exec systemctl suspend;;
        Lock) exec systemctl --user start lock.target;;
esac
