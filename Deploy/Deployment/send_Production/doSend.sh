#!/bin/bash

MACH=$1
FILE=$2
	#info for QA machine
	if  [ $MACH == 'FE' ]
        then
                #10.0.2.16 is a Prod FrontEnd machine Master
        	IP_D="10.0.2.16"
        	USER_M="emadt"
       		PASS_M="password"

		#10.0.2.17 is a Prod FrontEnd machine SLAVE
                IP_S="10.0.2.17"
                USER_M="emadt"
                PASS_M="password"
	else
		#10.0.2.14 is a Prod BackEnd machine Master
		IP_D="10.0.2.14"
                USER_M="franny"
                PASS_M="fgsoccer7"

		#10.0.2.15 is a Prod BackEnd machine SLAVE
                IP_S="10.0.2.15"
                USER_M="franny"
                PASS_M="fgsoccer7"

	fi

# password for Prod root
pAs="passwd"

# Deleteing old Package zip file from FE Master
/usr/bin/sshpass -p ${pAs} ssh -t root@"${IP_D}" "cd /home/${USER_M}/Production/Packages/; sudo rm *.zip;cd /var/www/ishop; sudo yes | cp -rf ./* ../Backup/; sudo rm -r FE"

# Send New package to ~/Production/Files/
cd ~/Deploy/Deployment/Packages/
 sshpass -p "${PASS_M}" scp ${FILE} "${USER_M}"@"${IP_D}":~/Production/Packages/

# Unzip and Host new pkg files to /var/www/DepTest/
/usr/bin/sshpass -p ${pAs} ssh -t root@"${IP_D}" "sudo unzip -o /home/${USER_M}/Production/Packages/${FILE} -d /var/www/ishop/; cd /var/www/ishop/FE; sudo yes | cp -rf ./* .."

# Restart Apache
/usr/bin/sshpass -p ${pAs} ssh -t root@"${IP_D}" "sudo systemctl restart apache2.service"

# FROM SLAVE ASWELL
# Delete old pkg files from ~/deploy/Production/Packages/ 
# Delete files from /var/www/Backup/
# mv files from /var/www/DepTest to /var/www/Backup/

# Deleteing old Package zip file from FE Master
/usr/bin/sshpass -p ${pAs} ssh -t root@"${IP_S}" "cd /home/${USER_M}/Production/Packages/; sudo rm *.zip;cd /var/www/ishop; sudo yes | cp -rf ./* ../Backup/; sudo rm -r FE"

# Send New package to ~/Production/Files/
cd ~/Deploy/Deployment/Packages/
 sshpass -p "${PASS_M}" scp ${FILE} "${USER_M}"@"${IP_S}":~/Production/Packages/

# Unzip and Host new pkg files to /var/www/ishop/
/usr/bin/sshpass -p ${pAs} ssh -t root@"${IP_S}" "sudo unzip -o /home/${USER_M}/Production/Packages/${FILE} -d /var/www/ishop/; cd /var/www/ishop/FE; sudo yes | cp -rf ./* .."

# Restart Apache
/usr/bin/sshpass -p ${pAs} ssh -t root@"${IP_S}" "sudo systemctl restart apache2.service"	 
