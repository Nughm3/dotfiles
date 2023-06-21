#!/usr/bin/env bash

SESSION_FILE="/tmp/pomodoro-session"

function notify() {
  notify-send --app-name "Pomodoro" "$@"
}

function pomodoro() {
  while true; do
    notify "Work time" "25 minutes"
    sleep 1500
    notify "Break time" "5 minutes"
    sleep 300
  done
}

function stop() {
  if [ -f $SESSION_FILE ]; then
    while read -r pid; do
      kill $pid
    done < $SESSION_FILE
    rm $SESSION_FILE
  fi
}

function start() {
  stop
  pomodoro &
  echo $! > $SESSION_FILE
}

function toggle() {
  if [ -f $SESSION_FILE ]; then
    notify "Session stopped"
    stop
  else
    notify "Session started"
    start
  fi
}

if [ "$1" = "start" ]; then
  notify "Session started"
  start
elif [ "$1" = "stop" ]; then
  notify "Session stopped"
  stop
elif [ "$1" = "toggle" ]; then
  toggle
else
  echo "Usage: pomodoro.sh [start|stop|toggle]"
  if [ "$1" != "-h" ] && [ "$1" != "--help" ]; then
    exit 1
  fi
fi
