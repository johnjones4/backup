#!/bin/bash

create_branch() {
  pwd
  branch="${1#origin/}"
  exists=`git show-ref refs/heads/$branch`
  if [ ! -n "$exists" ]; then
    echo "Creating $branch"
    git branch --track "$branch" "$1"
  fi
}

backup_repo () {
  repo_path="$DATA_DIR/$1"
  echo "Updating $repo_path"
  if [ ! -d "$repo_path" ]
  then
    echo "Initializing repo"
    mkdir -p "$repo_path"
    cd "$repo_path"
    echo "Cloning"
    git clone --recursive "git@github.com:$1.git" .
    if [ "$?" != "0" ]; then
      exit 1
    fi
  else
    cd "$repo_path"
    git status
    if [ "$?" != "0" ]; then
      echo "Initializing repo"
      git clone --recursive "git@github.com:$1.git" .
      if [ "$?" != "0" ]; then
        exit 1
      fi
    fi
  fi
  echo "Creating all branches from remote"
  git branch -r | grep -v '\->' | while read remote; do create_branch $remote; done
  echo "Fetching"
  git fetch -f --all
  if [ "$?" != "0" ]; then
    exit 1
  fi
}

backup_org () {
  repos=$(gh repo list $1 --json nameWithOwner --jq '.[].nameWithOwner')
  while IFS= read -r repo; do
    backup_repo $repo
  done <<< "$repos"
}

while :
do
  while IFS= read -r org; do
    backup_org $org
  done < "$ORG_FILE"
  sleep "$DELAY_STD"
done
