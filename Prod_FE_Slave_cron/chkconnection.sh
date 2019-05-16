#!/bin/bash

if  `timeout 5 ping 10.0.2.16 &>/dev/null` 
	then 
	echo "Working"

else 
	echo "Host not Found" >> ~/Desktop/failedconnect.txt
	sudo a2ensite 003-ishop.conf
	sudo systemctl start apache2.service
	sudo systemctl restart apache2.service

fi


#while ! ping -c1 10.0.2.14 &>/dev/null 
#do echo "Ping Fail"
#done
#echo "Host Found"

###if [  `ping -c2 10.0.2.14` ]
###then 
###	echo "no ping"
###else
###	echo "connected"
###fi


