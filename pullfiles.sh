#!/bin/bash
#VillainMod Git Handler

DEF_DIR = "VillainMod"

echo "Welcome to the VillainMod Git Handler"
echo "Current Directory: "$PWD
echo "Create working directory here? [Y/n]:"

read confirm_dir_create

if [ "$confirm_dir_create" == "Y" ] 
then
  echo "Creating directory 'VillainMod'"
  mkdir "$PWD/$DEF_DIR"
fi

if [[ -n "$1" ]]
# Test whether command-line argument is present (non-empty).
then
  lines=$1
else  
  lines=$LINES # Default, if not specified on command-line.
fi 

