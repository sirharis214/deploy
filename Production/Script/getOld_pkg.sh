#!/bin/bash

MACH=$1
FILE=$2
        #info for Deploy  machine
                #10.0.2.9 is the Deploy machine
                IP_D="10.0.2.9"
                USER_M="haris"
                PASS_M="p"
        
# Delete old pkg files from ~/deploy/Production/Packages
# Delete files from /var/www/Backup/
# mv files from /var/www/DepTest to /var/www/Backup/

cd ~/Production/Packages/
sudo rm -r ./*.zip
cd /var/www/Backup/
sudo rm -r ./*
cd /var/www/ishop/
sudo yes | cp -rf ./* /var/www/Backup/

# Get old package from Deploy
# ~/Deploy/Deployment/Packages/

# password for Deploy root
pAs="passwd"

/usr/bin/sshpass -p ${PASS_M} ssh -t "${USER_M}"@"${IP_D}" "cd /home/${USER_M}/Deploy/Deployment/send_Production/; ./oldSend.sh ${MACH} ${FILE};"

exit 0
