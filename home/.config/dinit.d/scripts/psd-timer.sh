#!/usr/bin/env bash

while true
do
  /usr/bin/profile-sync-daemon resync
  sleep 3600
done
