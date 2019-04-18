Deployment directory has all neccessary files to run on Deployment VM FOR NOW.
Development directory has all neccessary files to run on Dev-FE VM FOR NOW.

Concept:
* Download Deployment directory on VM that is running Deployment.
  Must have Database setup.
  See Repo for .sql
  Start Server -> /Deployment/Deploy_Server/Server2.php
* Download Development Directory on VM running as Dev.
* Jump into Development Directory/Dev/
* We are running a php file called makePackage.php which is similar to testRabb
  itMQClient.php from earlier.
* It starts by making a request Thru RMQ to Server for latest Version # for it's machine.
  Every VM has a IP assigned, and there for by knowing IP, We know wether it is DEV -> FE/BE
* After getting Version# it increments response by 1, and sends machineName (FE) and newVersion, as a parameter to a script called package.sh
* package.sh creates a new package of a specific folder with a new name, the new name includes the NEW version number at the end.
* After zipping, the script also sends a few commands to the Deploy Server which unzip's the package and stores it in a particular location.

# As of now that is all.. Lots more to come soon.
# Haris - 04:44 am 04/12/2019

# Haris - 12:25 am 04/18/2019   UPDATE:
* package.sh script is now using the variable MACH (FE/BE) which is given from 
  makepackage.php to determine which files to zip and send.
* makepackage.php also updates the DevTable with new version number and filename after
  sending the package to Deploy
