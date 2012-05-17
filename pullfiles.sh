#!/bin/bash
#VillainMod Git Handler


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

