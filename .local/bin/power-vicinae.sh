#!/bin/sh

case "$(echo -e "Shutdown\nRestart\nHibernate\nLogout\nSuspend\nLock" | vicinae dmenu --placeholder 'Power options' --no-section --no-footer --height 320)" in
        Shutdown) exec systemctl poweroff;;
        Restart) exec systemctl reboot;;
        Hibernate) exec systemctl hibernate;;
        Logout) niri msg action quit -s;;
        Suspend) exec systemctl suspend;;
        Lock) exec systemctl --user start lock.target;;
esac
