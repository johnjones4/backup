#!/bin/bash

while :
do
  ./backup.sh &> /tmp/log.txt
  curl -X POST --data-binary @/tmp/log.txt http://jabba-loghandler:8060/api/job/backup
  rm /tmp/log.txt
  sleep "$DELAY_DAILY"
done
