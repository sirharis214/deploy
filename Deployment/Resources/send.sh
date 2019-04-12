#!/bin/bash

	#Info for Deploy VM
	IP_D="10.0.2.9"
	USER_M="haris"
	PASS_M="p"

IP_M="$(ifconfig enp0s3 | grep 'inet ' | awk '{print $2}' | cut -d/ -f1)"
echo ${IP_M}

# $V = get version # from deploy table using RMQ
# $V++
# make zip file -> foldername_$V.zip FE/*
# send foldername_$V.zip 

if [ $IP_M == "10.0.2.9" ]
then
#zip files you want to send	
	cd ~/Desktop/Package
	zip FE.zip FE/*
#send to deploy VM	
	sshpass -p "${PASS_M}" scp FE.zip "${USER_M}"@"${IP_D}":~/Desktop/Get
# unzip in deploy vm and move to new location	
	sshpass -p "${PASS_M}" ssh "${USER_M}"@"${IP_D}" 'unzip ~/Desktop/Get/FE.zip; mv ./FE ~/Desktop'	
	exit

elif [ $IP_M == "10.0.2.21" ]
then
	cd ~/Desktop/Package
	zip BE.zip BE/*
	sshpass -p "${PASS_M}" scp BE.zip "${USER_M}"@"${IP_D}":~/Desktop/Get
	sshpass -p "${PASS_M}" ssh "${USER_M}"@"${IP_D}" 'unzip ~/Desktop/Get/BE.zip; mv ./BE ~/Desktop'
	exit
fi

	
	

#sshpass -p "${PASS_M}" scp Greet.txt "${USER_M}"@"${IP_D}":~/Desktop/Get
echo "${USER_M}"
echo "sent..."

#ADD REMOTE COMMANDS HERE
#sshpass -p "${PASS_M}" "${USER_M}"@"${IP_D}" 'unzip ~/Desktop/Get/FE.zip; mv ./FE ~/Desktop'
