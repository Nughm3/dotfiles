#!/bin/sh
    
case "$(echo "Shutdown\nRestart\nLogout\nSuspend\nLock" | dmenu)" in
        Shutdown) exec loginctl poweroff;;
        Restart) exec loginctl reboot;;
        Logout) kill -HUP $XDG_SESSION_PID;;
        Suspend) exec loginctl suspend;;
        Lock) exec loginctl --user start lock.target;;
esac
