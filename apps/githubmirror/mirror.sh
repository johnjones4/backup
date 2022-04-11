#!/bin/bash

create_branch() {
  branch="${1#origin/}"
  exists=`git show-ref refs/heads/$branch`
  if [ ! -n "$exists" ]; then
    git branch --track "$branch" "$1"
  fi
}

backup_repo () {
  repo_path="$DATA_DIR/$1"
  if [ ! -d "$repo_path" ]
  then
    mkdir -p "$repo_path"
    cd "$repo_path"
    git clone --recursive "git@github.com:$1.git" .
  else
    cd "$repo_path"
  fi
  git branch -r | grep -v '\->' | while read remote; do create_branch $remote; done
  git fetch -f --all
}

backup_org () {
  repos=$(gh repo list $1 --json nameWithOwner --jq '.[].nameWithOwner')
  while IFS= read -r repo; do
    backup_repo $repo
  done <<< "$repos"
}

while IFS= read -r org; do
  backup_org $org
done < "$ORG_FILE"
