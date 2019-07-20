#!/bin/bash

echo "This script will change to git user name and password"
echo 


# Git commands for user config
GIT_CONFIG="git config --global"
GIT_USER_NAME="$GIT_CONFIG user.name"
GIT_USER_EMAIL="$GIT_CONFIG user.email"

function read_config() {
	# Get current username and email
	CURRENT_USER_NAME="$($GIT_USER_NAME)"
	CURRENT_USER_EMAIL="$($GIT_USER_EMAIL)"

	# Display username and email
	echo "$1 user.name  : ${CURRENT_USER_NAME}"
	echo "$1 user.email : ${CURRENT_USER_EMAIL}"
	echo
}

read_config "Current"

# this can be implemented parametric 
if [ $# -eq 0 ]
  then
   echo "No arguments supplied"
   exit
fi

# Define username for private github
USER1_NAME=akatkar
USER1_MAIL=alikatkar@gmail.com
USER1_SSH=gmail_id_rsa

# Define username for company github
USER2_NAME=alikatkar
USER2_MAIL=ali.katkar@aurea.com
USER2_SSH=aurea_id_rsa

if [ "$CURRENT_USER_NAME" == "$USER1_NAME" ]
then
	NEW_USER_NAME=$USER2_NAME
	NEW_USER_EMAIL=$USER2_MAIL
	NEW_USER_SSH=$USER2_SSH	
else
	NEW_USER_NAME=$USER1_NAME
	NEW_USER_EMAIL=$USER1_MAIL
	NEW_USER_SSH=$USER1_SSH	
fi

#switch users
echo "switching users"
$GIT_USER_NAME $NEW_USER_NAME
$GIT_USER_EMAIL $NEW_USER_EMAIL
# Switch SSH key
#cp ~/.ssh/$NEW_USER_SSH ~/.ssh/id_rsa
#cp ~/.ssh/$NEW_USER_SSH.pub ~/.ssh/id_rsa.pub
#ssh-add ~/.ssh/id_rsa

# Read again and display as new
read_config "new"

#mv ~/.ssh/id_aurea_rsa ~/.ssh/aurea_id_rsa
#mv ~/.ssh/id_aurea_rsa.pub ~/.ssh/aurea_id_rsa.pub

#mv ~/.ssh/id_rsa_gmail ~/.ssh/gmail_id_rsa
#mv ~/.ssh/id_rsa_gmail.pub ~/.ssh/gmail_id_rsa.pub
