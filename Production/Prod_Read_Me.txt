Production must also clone this repo from ~

your ip are:
	10.0.2.14  FE
	10.0.2.15  BE

Deploy will send you the new package and move it to your /var/www/
restart Apache for good meaure.

SHOULD YOU WISH TO GO BACK TO AN OLD PACKAGE:

* Go to : ~/deploy/Production/Script
* Run the file called 
	./mark
* This script will find the current pkg you are hosting.
	* change the status of it to "bad" in Deploy : StatusTable
	* search for last pkg in Status for Prod FE/BE where status = "good"
		* if any pkg found - get filename
		* else ...
	* get filename of last working pkg and trigger Deploy to run script : ~/Deploy/Deployment/send_Production/oldSend.sh 
			* with 2 variables,  filename and machinetype (FE/BE)
	* pending : update StatusTable : old pkg is now hosting on Prod : FE/BE
	* maybe add time stamp to tables too...

