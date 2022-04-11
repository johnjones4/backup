#!/bin/bash

while :
do
  ./mirror.sh &> /tmp/log.txt
  curl -X POST --data-binary @/tmp/log.txt http://jabba-loghandler:8060/api/job/github
  rm /tmp/log.txt
  sleep "$DELAY_STD"
done
