#!/bin/bash
#VillainMod Git Handler

# function to actually sync our local repositories with the remote ones, without losing any untracked changes (COUGH REPO)
fetch_remotes()
{
    # for each subfolder, decide if it is a valid git repository
    for folder in *
    do
        cd ${folder}
        if [ -d ${folder}/.git ]
        then
            # if uncommitted changes exist, stash them
            changes=0
            # detect changes to existing files
            git diff --no-ext-diff --quiet --exit-code || changes=1
            # if no changed files, did they add any more?
            if [ $changes = 0 ]; then
                changes=`git ls-files --exclude-standard --others| wc -l`
            fi
            # if changes = 1, then stuff needs stashed as a backup
            if [ $changes = 1 ]
            then
                printf "Changes found in local repository, ${folder} - stashing as backup, then automatically merging with upstream\n"
                git stash
                changes=0
            else
                printf "No changes to be stashed. Proceeding to fetch and merge\n"
                changes=0
            fi
            
            git fetch origin
            git merge origin/master
            
        else
        
        fi
            

    done
}

DEF_DIR="VillainMod"

printf "Welcome to the VillainMod Git Handler\n"
printf "Current Directory:\n$PWD\n\n"
printf "Create working directory here? [Y/n]: "

read confirm_dir_create

shopt -s nocasematch

if [[ "$confirm_dir_create" == "Y" || "$confirm_dir_create" == "" ]] 
then
  printf "\nCreating directory 'VillainMod'...\n"
  if [[ -d VillainMod ]]
  then
    printf "Cannot create directory: already present!\n"
    # TO DO: do something if the dir is already present
  else
    mkdir "$PWD/$DEF_DIR"
  fi
fi

if [[ -n "$1" ]]
# Test whether command-line argument is present (non-empty).
then
  lines=$1
else  
  lines=$LINES # Default, if not specified on command-line.
fi 

