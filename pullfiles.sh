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
            # TODO if uncommitted changes exist, stash them
            
            # appears there is a valid git repository here - let's sync
            git fetch origin
            # TODO and now let's merge the upstream changes with any local ones, without losing data
            
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

