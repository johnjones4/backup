#!/bin/bash

PROJECT="$1"
TAG="ghcr.io/johnjones4/backup-$PROJECT"

docker build -t ${TAG} "./apps/$PROJECT"
docker push ${TAG}:latest
docker image rm ${TAG}:latest

