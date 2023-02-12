#!/bin/sh

case "$(echo -e "Shutdown\nRestart\nLogout\nSuspend\nLock" | dmenu)" in
        Shutdown) exec systemctl poweroff;;
        Restart) exec systemctl reboot;;
        Logout) pkill dwm;;
        Suspend) exec systemctl suspend;;
        Lock) exec systemctl --user start lock.target;;
esac
