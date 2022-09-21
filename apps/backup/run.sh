#!/bin/bash

while :
do
  ./backup.sh
  sleep "$DELAY_DAILY"
done
