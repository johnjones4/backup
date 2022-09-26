#!/bin/bash

while :
do
  lpass export > /data/passwords.csv
  if [ "$?" != "0" ]; then
    exit 1
  fi
  sleep "$DELAY_STD"
done
