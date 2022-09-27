#!/bin/bash

export PGPASSWORD="$POSTGRES_PASSWORD"

while :
do
  echo "Backing up docker"
  mkdir /backup/docker
  DOCKER_IDS=$(docker ps -q)
  for ID in $DOCKER_IDS
  do
    docker inspect $ID > /backup/docker/$ID.json
    if [ "$?" != "0" ]; then
      exit 1
    fi
  done

  echo "Backing up files"
  tar zcvf /backup/apps.tar.gz /apps
  if [ "$?" != "0" ]; then
    exit 1
  fi

  while read d; do
    echo "Backing up database $d"
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
