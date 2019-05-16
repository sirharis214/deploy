#!/bin/bash

# This script will first download ufw for firewall
# Then setup which to allow in and what to block.
# Run this script on Prod master slave FE and BE


# Update
echo -e "\nUpdating ...\n"
sudo apt-get update

# Install ufw
echo -e "Installing ufw ...\n"
sudo apt-get install ufw -y

# block all incoming
echo -e "Blocking all Incoming...\n"
sudo ufw default deny incoming

# Allow outgoing
echo -e "Allowing Outgoing...\n"
sudo ufw default allow outgoing

# Allow ssh
echo -e "Allowing ssh...\n"
sudo ufw allow 22

# Allow apache
echo -e "Allowing apache2...\n"
sudo ufw allow apache

# Allow mysql
echo -e "Allowing mysql...\n"
sudo ufw allow 3306

# Allow HTTP
echo -e "Allowing ssh...\n"
sudo ufw allow 80

# Allow rmq
echo -e "Allowing RMQ...\n"
sudo ufw allow 5672

# Allow rmq gui
echo -e "Allowing RMQ GUI...\n"
sudo ufw allow 15672

# Allow Deploy
echo -e "Allowing Deploy VM...\n"
sudo ufw allow from 10.0.2.9

# Allow Prod FE master & Slave
echo -e "Allowing All Prod lvl master's & slave's\n"
sudo ufw allow from 10.0.2.14
sudo ufw allow from 10.0.2.15
sudo ufw allow from 10.0.2.16
sudo ufw allow from 10.0.2.17

# Enable firewall
echo -e "Enabling Firewall....\n"
sudo ufw enable

# check status 
echo -e "Checking status of Firewall"
echo -n "....."
sleep 2
echo -n "..........."
sleep 2
echo -n ".............."
sleep 2
echo -en "......................................\n"
sleep 2
sudo ufw status verbose

