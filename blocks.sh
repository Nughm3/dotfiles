#!/usr/bin/env bash

while true; do
    date="$(date '+%b %d [ %a ] %R ')"
    icon="$(upower -d | grep icon-name: | tail -2 | head -1 | awk '{ print $2 }' | sed s/\'//g)"
    level="$(acpi | cut -d ',' -f2 | xargs)"
    stat="$(upower -d | grep 'state' | head -1 | cut -d ':' -f2 | xargs)"

    if [ "$stat" = "charging" ]; then
        stats="[+]"
        time="$(upower -d | grep 'time to' | head -1 | cut -d ':' -f2 | xargs)"
    elif [ "$stat" = "discharging" ]; then
        stats="[-]"
        time="$(upower -d | grep 'time to' | head -1 | cut -d ':' -f2 | xargs)"
    else [ "$stat" = "pending-charge" ];
        stats="[~]"
        time="not charging"
    fi

    if [ "$icon" = "battery-full-symbolic" ] || [ "$icon" = "battery-full-charging-symbolic" ] || [ "$icon" = "battery-full-charged-symbolic" ]; then
        bat="  $level $stats $time"
    elif [ "$icon" = "battery-good-symbolic" ] || [ "$icon" = "battery-good-charging-symbolic" ]; then
        bat="  $level $stats $time"
    elif [ "$icon" = "battery-low-symbolic" ] || [ "$icon" = "battery-low-charging-symbolic" ]; then
        bat="  $level $stats $time"
    else
        bat="  $level $stats $time"
    fi
    xsetroot -name "$bat >> $date"
    sleep 1
done
