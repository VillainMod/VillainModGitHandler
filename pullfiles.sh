#!/bin/bash
#VillainMod Git Handler

# detect changes to a given git repo
detect_changes()
{
    changes=0
    # detect changes to existing files
    git diff --no-ext-diff --quiet --exit-code || changes=1
    # if no changed files, did they add any more?
    if [[ $changes = 0 ]]; then
        changes=`git ls-files --exclude-standard --others| wc -l`
    fi
    # now look at changes variable to see if changes exist

}

# function to actually sync our local repositories with the remote ones, without losing any untracked changes (COUGH REPO)
fetch_remotes()
{
    # for each subfolder, decide if it is a valid git repository
    for folder in *
    do
        cd ${folder}
        if [[ -d ${folder}/.git ]]
        then
            changes=0
            detect_changes
            
            # sync sources and merge
            git fetch origin
            git merge origin/master
            
            #if changes were stashed, let's re-apply them and hope for the best!
            if [[ $changes = 1 ]]
            then
                git stash pop
            fi
            
        #else
        #	something something
        fi
    done
}

push_changes() 
{
    # for each subfolder, decide if it is a valid git repository
    for folder in *
    do
        cd ${folder}
        if [[ -d ${folder}/.git ]]
        then
            changes=0
            detect_changes
            # now let's see if we should commit them
            if [[ $changes = 1 ]]
            then
                # changes were made, let's ask the user if they want to push them
                printf "Uncommitted changes detected, add all and commit? (this will add all new and changed files, ensure your .gitignore is set up correctly! [y/N]\n"
                read want_to_commit
                shopt -s nocasematch
                if [[ "$want_to_commit" == "Y" ]] 
                then
                    # user wants to add and commit all changes
                    git add .
                    git commit
                    # user will enter commit message and commit is now done
                    
                    # if user says they are allowed to push to the remote tree
                    if [[ $IS_REPO_ADMIN = 1 ]]
                    then
                        printf "Push these changes now? [y/N]\n"
                        read push_changes
                        if [[ "$push_changes" == "Y" ]]
                        then
                        
                            branch_name="$(git symbolic-ref HEAD 2>/dev/null)" || 
                            branch_name="(unnamed branch)"     # detached HEAD
                            branch_name=${branch_name##refs/heads/}
                        
                            git push origin $branch_name
                        fi
                    fi
                fi
            fi
        fi
    done    
}


pull_selected_devices()
{
	printf "You can only pull device trees for devices VillainMod officially supports.\n"
	printf "If you would like to build for an unsupported device, please pull the tree manually.\n"
	printf "To get official support for your device, please submit a patch via gerrit.\n"
	printf "Please select the manufacturer of your device:\n"
	printf "1:  HTC\n"
	printf "2:  Samsung\n"
	printf "Type the corresponding number and press ENTER:\n"
	read device_manufacturer
	if [[ "$device_manufacturer" == "1" ]]
	then
		printf "Device Manufacturer: HTC"
		printf "Please choose a device:\n"
		#TODO: Add list of supported HTC devices.
	elif [[ "$device_manufacturer" == "2" ]]
	then
		printf "Device Manufacturer: Samsung"
		printf "Please choose a device:\n"
		printf "1:  Galaxy S2\n"
		printf "Type the corresponding number and press ENTER:\n"
		read manufacturer_model
		#TODO: Add pull code.
		if [[ "$manufacturer_model" == "1" ]]
		then
			#Check device folder exists
			if [[ ! -d "device" ]]; then
      			printf "Device directory does not exist!\n"
				printf "Creating directory..\n"
				mkdir -p "device"
				cd "device"
				if [[ ! -d "samsung" ]]; then
					mkdir -p "samsung"
					cd "samsung"
					git clone "git@github.com:VillainMod/android_device_samsung_galaxys2.git"
				else
					cd "samsung"
					git clone "git@github.com:VillainMod/android_device_samsung_galaxys2.git"
				fi
    		else
				cd "device"
				if [[ ! -d "samsung" ]]; then
					mkdir -p "samsung"
					cd "samsung"
					git clone "git@github.com:VillainMod/android_device_samsung_galaxys2.git"
				else
					cd "samsung"
					git clone "git@github.com:VillainMod/android_device_samsung_galaxys2.git"
				fi
			fi
		fi
	#else
		#TODO: Add stuff to do if input is unexpected.
	fi
}

display_menu()
{
  printf "1: Sync local tree\n"
  printf "2: Push local changes\n"
  printf "3: Pull device trees\n"
  printf "What would you like to do? [1-3]:\n"
  read menu_choice
  if [[ "$menu_choice" == "1" ]]
  then
    printf "Syncing local tree\n"
  elif [[ "$menu_choice" == "2" ]]
  then
	printf "Gathering local changes\n"
  elif [[ "$menu_choice" == "3" ]]
  then
	pull_selected_devices
  else
	printf "What would you like to do? [1-3]:\n"
	read menu_choice
  fi
}

DEF_DIR="VillainMod"
# if the user has write access to push to the repo (this is self-selected by the user, it's not a security feature, just enables push features)
IS_REPO_ADMIN="1"

printf "Welcome to the VillainMod Git Handler\n"
printf "Current directory:\n$PWD\n\n"


if [[ ! -d VillainMod ]]
then
  printf "Create working directory here? [Y/n]: "
  read confirm_dir_create
  if [[ "$confirm_dir_create" == "Y" || "$confirm_dir_create" == "" || "$confirm_dir_create" == "y" ]] 
  then
    printf "\nCreating directory 'VillainMod'...\n"
    mkdir "$PWD/$DEF_DIR"
  else
    printf "Specify working directory:\n"
    read alt_working
    while [[ ! -d $alt_working ]]; do
      printf "\nNo such directory! Specify working directory:\n"
      read alt_working
    done
    cp $PWD/pullfiles.sh $alt_working
    cd $alt_working
    # Although the following line does what it's supposed to (start the
    # script in the new dir), the original script's process (in the old dir)
    # will still be running and will exit only when the "child" script exits.
    # Also opens up a door for scriptception.
    ./pullfiles.sh && exit 0
  fi
else
  printf "Found working directory 'VillainMod'!\n"
  # TO DO: do stuff if the dir is already present
  #call menu function
  display_menu
fi    



if [[ -n "$1" ]]
# Test whether command-line argument is present (non-empty).
then
  lines=$1
else  
  lines=$LINES # Default, if not specified on command-line.
fi 

