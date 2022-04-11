#!/bin/bash

archive_source () {
  archivedir=/data/"$1"
  mkdir -p "$archivedir"
  rclone sync --tpslimit 13 "$1": "$archivedir" &> /tmp/log.txt
  curl -X POST --data-binary @/tmp/log.txt http://jabba-loghandler:8060/api/job/rclone
  rm /tmp/log.txt
}

archive_sources () {
  for remote in $(echo $REMOTES | sed "s/,/ /g")
  do
    echo "$remote"
    archive_source "$remote"
  done
}

while :
do
  archive_sources
  sleep "$DELAY_STD"
done
