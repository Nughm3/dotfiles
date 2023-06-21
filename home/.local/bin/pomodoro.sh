#!/usr/bin/env bash

SESSION_FILE="/tmp/pomodoro-session"

function pomodoro() {
  while true; do
    notify-send "Work time" "25 minutes"
    sleep 5
    notify-send "Break time" "5 minutes"
    sleep 5
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

if [ "$1" = "start" ]; then
  start
  echo "Session started"
elif [ "$1" = "stop" ]; then
  stop
  echo "Session stopped"
else
  echo "Usage: pomodoro.sh [start|stop]"
  if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    exit 0
  else
    exit 1
  fi
fi
