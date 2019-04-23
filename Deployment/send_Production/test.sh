#!/bin/bash


MACH="FE"
FILE="FE_version_4.zip"
#MACH=$1
#FILE=$2
        #info for QA machine
        if  [ $MACH == 'FE' ]
        then
                #10.0.2.14 is a Prod FrontEnd machine
                IP_D="10.0.2.14"
                USER_M="ahsan"
                PASS_M="Ahsan121"
        else
                #10.0.2.15 is a Prod BackEnd machine
                IP_D="10.0.2.15"
                USER_M="ahsan"
                PASS_M="Ahsan121"
        fi

# password for QA root
##pAs="passwd"

# Delete old pkg files from ~/deploy/Production/Packages/ 
# Delete files from /var/www/Backup/
# mv files from /var/www/DepTest to /var/www/Backup/

##/usr/bin/sshpass -p ${pAs} ssh -t root@"${IP_D}" "cd /home/${USER_M}/deploy/Production/Packages/; sudo rm *.zip; cd /var/www/Backup/; sudo rm -r ./* ; cd /var/www/DepTest; sudo mv -f ./* ../Backup/"

# Send New package to ~/deploy/QA/Files/
cd ~/Deploy/Deployment/Packages/
 sshpass -p "${PASS_M}" scp ${FILE} "${USER_M}"@"${IP_D}":~/deploy/Production/Packages/

# Unzip and Host new pkg files to /var/www/DepTest/

##/usr/bin/sshpass -p ${pAs} ssh -t root@"${IP_D}" "sudo unzip /home/${USER_M}/deploy/Production/Packages/${FILE} -d /var/www/DepTest/"






