#!/bin/bash

mkdir -p /data/gmail

mkdir -p /data/proton

/src/proton-bridge-2.3.0/proton-bridge --noninteractive &

sleep 10

while :
do
  offlineimap -o -c /config/offlineimaprc
  if [ "$?" != "0" ]; then
    exit 1
  fi
  sleep "$DELAY_DAILY"
done
