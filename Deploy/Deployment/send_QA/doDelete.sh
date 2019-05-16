#!/bin/bash

MACH=$1
FILE=$2

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

# password for QA root
pAs="passwd"

# Delete All text files and index.php from /var/www/ishop
/usr/bin/sshpass -p ${pAs} ssh -t root@"${IP_D}" "cd /home/${USER_M}/QA/Files/;sudo rm *.zip; cd /var/www/ishop/; sudo rm -r ./*; cd /var/www/; sudo cp -r rabbitMQFiles ./ishop"

# Send New package to ~/QA/Files/
cd ~/Deploy/Deployment/Packages/
 sshpass -p "${PASS_M}" scp ${FILE} "${USER_M}"@"${IP_D}":~/QA/Files/


# Unzip and Host new pkg files to /var/www/ishop/
#/usr/bin/sshpass -p ${pAs} ssh -t root@"${IP_D}" "sudo unzip /home/${USER_M}/QA/Files/${FILE} -d /var/www/ishop/; cd /var/www/ishop/FE; sudo yes | cp -rf ./* .."

# Unzip and Host new pkg files to /var/www/ishop/
/usr/bin/sshpass -p ${pAs} ssh -t root@"${IP_D}" "sudo unzip /home/${USER_M}/QA/Files/${FILE} -d /home/${USER_M}/QA/Move/; cd /home/${USER_M}/QA/Move/${MACH}; sudo mv ./* /var/www/ishop"

# Restart Apache
/usr/bin/sshpass -p ${pAs} ssh -t root@"${IP_D}" "sudo systemctl restart apache2.service"
