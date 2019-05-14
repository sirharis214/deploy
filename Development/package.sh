#!/bin/bash
#set -x

MACH=$1
VER=$2

# You must manually send a sample file via scp to deploy vm to ensure this script has access to vm.
# Info for Deploy VM
        IP_D="10.0.2.9"
        USER_M="haris"
        PASS_M="p"

	# Use MACH variable which is the machine type (FE/BE), to determine which folders to zip & send.

	if  [ $MACH == 'FE' ]
	
	then
		# 10.0.2.10 is a DEV FrontEnd machine
		# zip files you want to send
       		 cd ~/Development/Zip/
	      		zip -r FE_version_${VER}.zip FE/*
		# send to deploy VM
        		sshpass -p "${PASS_M}" scp FE_version_${VER}.zip "${USER_M}"@"${IP_D}":~/Deploy/Deployment/Packages
		# unzip in deploy vm and move to new location
        		sshpass -p "${PASS_M}" ssh "${USER_M}"@"${IP_D}" "unzip -o /home/${USER_M}/Deploy/Deployment/Packages/FE_version_'${VER}'.zip -d /home/${USER_M}/Deploy/Deployment/Host"

		exit 0
	
	else
        	# 10.0.2.11 is a DEV BackEnd machine
        	# zip files you want to send
        	cd ~/Development/Zip/
                	zip -r BE_version_${VER}.zip BE/*
        	#send to deploy VM
                	sshpass -p "${PASS_M}" scp BE_version_${VER}.zip "${USER_M}"@"${IP_D}":~/Deploy/Deploment/Packages
        	#unzip in deploy vm and move to new location
                	sshpass -p "${PASS_M}" ssh "${USER_M}"@"${IP_D}" "unzip -o /home/${USER_M}/Deploy/Deployment/Packages/BE_version_'${VER}'.zip -d /home/${USER_M}/Deploy/Deployment/Host"

        fi

