#!/bin/bash
#set -x

MACH=$1
VER=$2

#Info for Deploy VM
        IP_D="10.0.2.9"
        USER_M="haris"
        PASS_M="p"


IP_M="$(ifconfig enp0s3 | grep 'inet ' | awk '{print $2}' | cut -d/ -f1)"
echo "${IP_M}"

echo "ip is ${IP_M} machine is ${MACH} version is ${VER}"

	if [ $IP_M == "10.0.2.20" ]
	then
	#10.0.2.20 is a DEV FrontEnd machine
	#zip files you want to send
       	cd ~/Desktop/Haris/DoZip
	      	zip FE_version_${VER}.zip FE/*
	#send to deploy VM
        	sshpass -p "${PASS_M}" scp FE_version_${VER}.zip "${USER_M}"@"${IP_D}":~/Desktop/Deploy/Packages
	# unzip in deploy vm and move to new location
        	sshpass -p "${PASS_M}" ssh "${USER_M}"@"${IP_D}" 'unzip ~/Desktop/Deploy/Packages/FE_version_'${VER}'.zip -d ~/Desktop/Deploy/Host'
        exit
	fi
