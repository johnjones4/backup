#!/bin/bash

archive_source () {
  archivedir=/data/"$1"
  mkdir -p "$archivedir"
  rclone sync --tpslimit 13 "$1": "$archivedir"
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
