#!/bin/bash
#set -x

MACH=$1
VER=$2

#Info for Deploy VM
        IP_D="10.0.2.9"
        USER_M="haris"
        PASS_M="p"


#IP_M="$(ifconfig enp0s3 | grep 'inet ' | awk '{print $2}' | cut -d/ -f1)"
#echo "${IP_M}"

#use MACH variable to determine which folders to zip n send, it will be either FE or BE
echo "ip is ${IP_M} machine is ${MACH} version is ${VER}"
	if  [ $MACH == 'FE' ]
	#if [ $IP_M == '10.0.2.10' ] not using IP_M
	then
		#10.0.2.10 is a DEV FrontEnd machine
		#zip files you want to send
       		cd ~/deploy/Development/DoZip/
	      		zip FE_version_${VER}.zip FE/*
		#send to deploy VM
        		sshpass -p "${PASS_M}" scp FE_version_${VER}.zip "${USER_M}"@"${IP_D}":~/Desktop/Deploy/Packages
		# unzip in deploy vm and move to new location
        		sshpass -p "${PASS_M}" ssh "${USER_M}"@"${IP_D}" 'unzip ~/Desktop/Deploy/Packages/FE_version_'${VER}'.zip -d ~/Desktop/Deploy/Host'

		exit 0
	
	else
        	#10.0.2.11 is a DEV FrontEnd machine
        	#zip files you want to send
        	cd ~/deploy/Development/DoZip/
                	zip BE_version_${VER}.zip BE/*
        	#send to deploy VM
                	sshpass -p "${PASS_M}" scp BE_version_${VER}.zip "${USER_M}"@"${IP_D}":~/Desktop/Deploy/Packages
        	#unzip in deploy vm and move to new location
                	sshpass -p "${PASS_M}" ssh "${USER_M}"@"${IP_D}" 'unzip ~/Desktop/Deploy/Packages/BE_version_'${VER}'.zip -d ~/Desktop/Deploy/Host'

        fi

