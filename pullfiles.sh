#!/bin/bash
#VillainMod Git Handler

# function to actually sync our local repositories with the remote ones, without losing any untracked changes (COUGH REPO)
fetch_remotes()
{

}

<<<<<<< HEAD
DEF_DIR="VillainMod"
=======

>>>>>>> 85685f79b46d51fd81c164bfd01aab19e9457ffa

printf "Welcome to the VillainMod Git Handler\n"
printf "Current Directory:\n$PWD\n\n"
printf "Create working directory here? [Y/n]: "

read confirm_dir_create

shopt -s nocasematch

if [[ "$confirm_dir_create" == "Y" || "$confirm_dir_create" == "" ]] 
then
<<<<<<< HEAD
  printf "\nCreating directory 'VillainMod'...\n"
  if [[ -d VillainMod ]]
  then
    printf "Cannot create directory: already present!\n"
    # TO DO: do something if the dir is already present
  else
    mkdir "$PWD/$DEF_DIR"
  fi
=======
  echo "Creating directory 'VillainMod'"
  mkdir -p "VillainMod"
elif [ "$confirm_dir_create" == "n" ]
  echo "Type the path to the directory you would like to work from"
  read working_dir
  cd "$working_dir"
elif [ "$confirm_dir_create" == "" ]
  echo "Creating directory VillainMod"
  mkdir -p "VillainMod"
>>>>>>> 85685f79b46d51fd81c164bfd01aab19e9457ffa
fi

if [[ -n "$1" ]]
# Test whether command-line argument is present (non-empty).
then
  lines=$1
else  
  lines=$LINES # Default, if not specified on command-line.
fi 

