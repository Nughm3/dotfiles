#!/bin/sh

case "$(echo -e "Shutdown\nRestart\nLogout\nSuspend\nLock" | fuzzel --dmenu)" in
        Shutdown) exec loginctl poweroff;;
        Restart) exec loginctl reboot;;
        Logout) riverctl exit;;
        Suspend) exec loginctl suspend;;
        Lock) exec loginctl --user start lock.target;;
esac
