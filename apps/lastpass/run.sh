#!/bin/bash

while :
do
  lpass export > /data/passwords.csv
  status=$?
  if [ "$status" -ne "0" ]; then
    curl -X POST --data "error: $status" http://jabba-loghandler:8060/api/job/lastpass
  else
    curl -X POST --data "ok: $status" http://jabba-loghandler:8060/api/job/lastpass
  fi
  sleep "$DELAY_STD"
done
