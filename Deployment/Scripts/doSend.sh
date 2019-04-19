#!/bin/bash

MACH=$1
FILE=$2
	#info for QA machine
	if  [ $MACH == 'FE' ]
        then
                #10.0.2.12 is a QA FrontEnd machine
        	IP_D="10.0.2.12"
        	USER_M="ahsan"
       		PASS_M="Ahsan121"
	else
		#10.0.2.13 is a QA BackEnd machine
		IP_D="10.0.2.13"
                USER_M="ahsan"
                PASS_M="Ahsan121"
	fi

	#info for Deploy machine

	cd ~/Deploy/Deployment/Packages/
	 sshpass -p "${PASS_M}" scp ${FILE} "${USER_M}"@"${IP_D}":~/Deploy/deploy/QA/Files/

	 #unzip in deploy vm and move to new location

pAs="passwd"
/usr/bin/sshpass -p ${pAs} ssh root@"${IP_D}" "sudo unzip /home/ahsan/Deploy/deploy/QA/Files/'${FILE}' -d /var/www/DepTest/"
	 #/usr/bin/sshpass -p 'Ahsan121' ssh -t ahsan@10.0.2.12 "sudo unzip ~/Deploy/deploy/QA/Files/'${FILE}' -C /var/www/DepTest/"
#                   /usr/bin/sshpass -p ${pas} ssh -t root@"${IP_D}" "unzip ~/Deploy/deploy/QA/Files/'${FILE}' -C /var/www/DepTest/"


