#!/bin/bash

# System Admin : Haris Nasir
# Read the file Website_Documentation.txt for any info regarding this script.
# Follow Steps on Website_Documentation.txt after this script is complete to finish setup process.

# update system
echo -e "\nApplying any new updates..."
sleep 2 
sudo apt-get update 

# Install apache2
echo -e "\nInstalling apache2..."
sleep 2
sudo apt-get install apache2 -y

# Install git
echo -e "\nInstalling git..."
sleep 2
sudo apt-get install git -y

# Install php
echo -e "\nInstalling php..."
sleep 2
sudo apt-get install php -y

# Install php-amqp
echo -e "\nInstalling php-amqp..."
sleep 2
sudo apt-get install php-amqp -y

# Install RMQ Server
echo -e "\nInstalling rabbitmq-server..."
sleep 2
sudo apt-get install rabbitmq-server -y

# Install Aptitude
echo -e "\nInstalling Aptitude..."
sleep 2
sudo apt-get install aptitude -y

# Install mysql-server
echo -e "\nInstalling mysql-server..."
sleep 2
sudo apt-get install mysql-server -y

# Install php-mysql
echo -e "\nInstalling php-mysql..."
sleep 2
sudo apt-get install php-mysql -y

# Download ssh 
echo -e "\n Downloading ssh..."
sleep 2
sudo apt-get install ssh -y

# Download sshpass
echo -e "\n Downloading sshpass..."
sleep 2
sudo apt-get install sshpass -y

# Download net-tools
echo -e "\n Downloading net-tools..."
sleep 2
sudo apt-get install net-tools -y

# Start rmq server
echo -e "\nStarting RMQ Server..."
sleep 2
sudo rabbitmq-server start
echo -e "\nEnabling Plugins for RMQ..."
sudo rabbitmq-plugins enable rabbitmq_management

# start apache service
echo -e "\nStarting apache2.service..."
sudo service apache2 restart

# RMQ SETTINGS
echo -e "\n_________________________________________"
echo -e "\n*******         *********          ******"
echo -e "\n_________________________________________"

# create user test test for rmq
echo -e "\nListing current RMQ users..."
sudo rabbitmqctl list_users
echo -e "\n   \n      Does the user: test   already exist? yes/no\n"
read ans
        if [ $ans = "yes" ]
        then
                echo "Don't need to create rmq user: test..."
        else
                echo "Let's Create the user: test  ..."
		echo -e "\nCreating RMQ user: test ..."
		sleep 2
		sudo rabbitmqctl add_user test test
		echo -e "\nSetting tags for  test  to administrator..."
		sudo rabbitmqctl set_user_tags test administrator
		echo -e "\nGiving  test  permissions for vhost  \ ..."
		sudo rabbitmqctl set_permissions -p / test ".*" ".*" ".*"
		echo -e "\n Done Creating user: test"
        fi

echo -e "\nRestart rabbitm-server..."
sudo invoke-rc.d rabbitmq-server restart

echo -e "\n ****      ****      ****     ****"
echo -e "\n     DOWNLOADING neccessary programs done \n GO READ Website_Documentation.txt To complete setup process !\n"
echo -e "   ****      ****      ****     ****\n"
echo -e "\nThis script will end in 9 seconds...."
sleep 9

