#!/bin/bash

export PGPASSWORD="$POSTGRES_PASSWORD"

while :
do
  tar zcf /backup/apps.tar.gz /apps
  if [ "$?" != "0" ]; then
    exit 1
  fi
  while read d; do
    echo "Backing up $d"
    rm /backup/"$d".sql
    rm /backup/"$d".sql.gz
    pg_dump "$d" -U $POSTGRES_USER -h $POSTGRES_HOST > /backup/"$d".sql
    if [ "$?" != "0" ]; then
      exit 1
    fi
    gzip /backup/"$d".sql
    if [ "$?" != "0" ]; then
      exit 1
    fi
    echo "Done"
  done </dbs.txt
  sleep "$DELAY_DAILY"
done
