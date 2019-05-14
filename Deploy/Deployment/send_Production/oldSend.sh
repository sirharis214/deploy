#!/bin/bash

MACH=$1
FILE=$2
	#info for Prod machine
	if  [ $MACH == 'FE' ]
        then
                #10.0.2.16 is a Prod FrontEnd machine
        	IP_D="10.0.2.16"
        	USER_M="emadt"
       		PASS_M="password"

		 #10.0.2.17 is a Prod FrontEnd slave
                IP_S="10.0.2.17"
                USER_M="emadt"
                PASS_M="password"
	else
		#10.0.2.14 is a Prod BackEnd machine
		IP_D="10.0.2.14"
                USER_M="franny"
                PASS_M="fgsoccer7"

		#10.0.2.15 is a Prod BackEnd slave
                IP_S="10.0.2.15"
                USER_M="franny"
                PASS_M="fgsoccer7"
	fi

# password for Production root
pAs="passwd"

# Deleteing old Package zip file from FE Master
/usr/bin/sshpass -p ${pAs} ssh -t root@"${IP_D}" "cd /home/${USER_M}/Production/Packages/; sudo rm *.zip;cd /var/www/ishop; sudo yes | cp -rf ./* ../Backup/"

# Send New package to Prod Master
cd ~/Deploy/Deployment/Packages/
 sshpass -p "${PASS_M}" scp ${FILE} "${USER_M}"@"${IP_D}":~/Production/Packages/

# Unzip and Host new pkg files to /var/www/ishop/
/usr/bin/sshpass -p ${pAs} ssh -t root@"${IP_D}" "sudo unzip /home/${USER_M}/Production/Packages/${FILE} -d /var/www/ishop/; cd /var/www/ishop/FE; mv ./* .."
	 
# Restart apache for Prod
/usr/bin/sshpass -p ${pAs} ssh -t root@"${IP_D}" "sudo systemctl restart apache2.service"


# Send New package to Slave ~/Production/Packages/

# Deleteing old Package zip file from FE Master
/usr/bin/sshpass -p ${pAs} ssh -t root@"${IP_S}" "cd /home/${USER_M}/Production/Packages/; sudo rm *.zip; cd /var/www/ishop/; sudo yes | cp -rf ./* ../Backup/"

cd ~/Deploy/Deployment/Packages/
 sshpass -p "${PASS_M}" scp ${FILE} "${USER_M}"@"${IP_S}":~/Production/Packages/

# Unzip and Host new pkg files to /var/www/ishop/
/usr/bin/sshpass -p ${pAs} ssh -t root@"${IP_S}" "sudo unzip /home/${USER_M}/Production/Packages/${FILE} -d /var/www/ishop/; cd /var/www/ishop/FE; mv ./* .."

# Restart apache for Prod
/usr/bin/sshpass -p ${pAs} ssh -t root@"${IP_S}" "sudo systemctl restart apache2.service"

