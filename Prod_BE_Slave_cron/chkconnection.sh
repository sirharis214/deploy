#!/bin/bash

sudo systemctl start ishop.service

	pAs="passwd"
echo "Deleteing testRabbitMQ.ini from FE..."
sshpass -p ${pAs} ssh -t root@10.0.2.17 "cd /var/www/ishop/rabbitMQFiles; sudo rm -r testRabbitMQ.ini;"

cd ~/Final490Proj/
echo "Sending FE new File slave..."
#sshpass -p "passwd" scp -t  testRabbitMQ.ini root@"10.0.2.17":/var/www/ishop/rabbitMQFiles/

sshpass -p "passwd" scp  testRabbitMQ.ini root@"10.0.2.17":/home/emadt/dummy
sshpass -p ${pAs} ssh  root@10.0.2.17 "cd /home/emadt/dummy/;sudo cp testRabbitMQ.ini /var/www/ishop/rabbitMQFiles/"

#testing if reachable to FE
#sshpass -p ${pAs} ssh -t root@10.0.2.17 "cd /home/emadt/dummy/; touch fromCron.txt;"

echo "Restarting apache on FE slave..."
sshpass -p ${pAs} ssh -t root@10.0.2.17 "sudo systemctl restart apache2.service"



#### On FE Master ####
echo "Sending FE master new File..."
#sshpass -p "passwd" scp -t testRabbitMQ.ini root@"10.0.2.17":/var/www/ishop/rabbitMQFiles/

sshpass -p "passwd" scp  testRabbitMQ.ini root@"10.0.2.16":/home/emadt/dummy/
sshpass -p ${pAs} ssh -t root@10.0.2.16 "cd /home/emadt/dummy/; sudo cp testRabbitMQ.ini /var/www/ishop/rabbitMQFiles/"

#testing if reachable to FE
#sshpass -p ${pAs} ssh -t root@10.0.2.16 "cd /home/emadt/dummy/; touch fromCron.txt;"

echo "Restarting apache on FE master..."
sshpass -p ${pAs} ssh -t root@10.0.2.16 "sudo systemctl restart apache2.service"
