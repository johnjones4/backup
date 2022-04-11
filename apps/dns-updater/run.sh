#!/bin/bash

while :
do
  ./update_dns.sh &> /tmp/log.txt
  curl -X POST --data-binary @/tmp/log.txt http://jabba-loghandler:8060/api/job/dns
  rm /tmp/log.txt
  sleep 86400
done
