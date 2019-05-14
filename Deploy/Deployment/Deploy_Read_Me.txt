To begin.
You must make sure your ip is 10.0.2.9

make sure your file path where you are working from is 
	~/Deploy/Deployment/

step 1: 
	Go into Deploy_Server and start the Server.php
step 2:
	After Dev has sent you a package.
		Your DevTable should have updated.
		zip File of pkg should be in Packages.
		unzipped version should be in Host. (opt)
step 3: 
	Now we must send to QA.
	Go into Directory called Scripts (~/Deploy/Deployment/Scripts/)
	In there you should see 2 shell scripts and a Directory.
	Go into /Send_QA.
		Run send_package.php
	This will send new pkg to QA machine/'s AND update statusTable.
	wait for update on status..before sending to Production.
step 4:
