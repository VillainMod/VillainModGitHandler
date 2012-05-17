#!/bin/bash
#VillainMod Git Handler

<<<<<<< HEAD
=======
# function to actually sync our local repositories with the remote ones, without losing any untracked changes (COUGH REPO)
fetch_remotes()
{

}

DEF_DIR = "VillainMod"
>>>>>>> 9bda140bcbd2b9b0d325bccfbb10b935a7b09c0f

echo "Welcome to the VillainMod Git Handler"
echo "Current Directory: "$PWD
echo "Create working directory here? [Y/n]:"

read confirm_dir_create

if [ "$confirm_dir_create" == "Y" ] 
then
  echo "Creating directory 'VillainMod'"
  mkdir -p "VillainMod"
elif [ "$confirm_dir_create" == "n" ]
  echo "Type the path to the directory you would like to work from"
  read working_dir
  cd "$working_dir"
elif [ "$confirm_dir_create" == "" ]
  echo "Creating directory VillainMod"
  mkdir -p "VillainMod"
fi

if [ -n "$1" ]
# Test whether command-line argument is present (non-empty).
then
  lines=$1
else  
  lines=$LINES # Default, if not specified on command-line.
fi 

