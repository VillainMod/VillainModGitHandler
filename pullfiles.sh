#!/bin/bash
#VillainMod Git Handler

echo "Welcome to the VillainMod Git Handler"


if [[ -n "$1" ]]
# Test whether command-line argument is present (non-empty).
then
  lines=$1
else  
  lines=$LINES # Default, if not specified on command-line.
fi 

