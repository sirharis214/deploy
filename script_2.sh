#!/bin/bash

# Run this file on all Vm's to allow Deployment to run root commands remotely.

# Script will not do one thing but it is important...
# Create a root password for deploy server to use...
# Type these commands manually on EVERY VM !!
#      sudo passwd root
#      Enter new Unix password:   passwd
#      ReEnter new Unix Password: passwd

# RUN THIS ONLY AFTER YOU ALREADY RAN script_1.sh

# Ready to Change sshd_config settings to allow Remote to exec root commands

echo -e "\nChange sshd_config settings to allow Remote vm to exec root commands"
sleep 5
echo -e "\nGo to the line where it says.. PermitRootLogin ..and uncomment it..."
sleep 5
echo -e "Erase 'prohibit-password' and replace it with the word   'yes' "
sleep 5
echo -e "** At the end restart ssh... by typing..."
sleep 4
echo    "        sudo systemctl restart ssh    "
sleep 4
echo -e "File will open for you to edit in.."
sleep 4
echo "3"
sleep 1
echo "2"
sleep 1
echo "1"
sleep 1

sudo vi /etc/ssh/sshd_config
