#!/usr/bin/php
<?php
 	require_once('path.inc');
        require_once('get_host_info.inc');
	require_once('rabbitMQLib.inc');
	
	getFile(); //get pkg file name from Packages directory in this vm

	function getFile()
	{
		//What file did you test
		$file = shell_exec("./getFile.sh");

		echo "current pkg is: $file".PHP_EOL;

		//change the status to Bad for this pkg in Deploy StatusTable
		updateTable($file);
	}

	function updateTable($file)
	{
		$ip = shell_exec("ifconfig enp0s3 | grep 'inet ' | awk '{print $2}' | cut -d/ -f1");
        echo "Your IP is: $ip";
        $machineType  = "";
        
                if (trim($ip) == "10.0.2.14"){

			$machineType = "FE";
			$lvl = "Prod";
                }               
                else{
                
			$machineType = "BE";
			$lvl = "Prod";
                }

                echo "Changing status for ".$machineType." ".$file."\n";

		//$status = exec('./getStatus.sh');   WE ARE NOT ASKING USER TO INPUT WHAT STATUS CHANGE IS, this script only changes to bad

		//changing status to bad
		$status = "bad";
		$filename = trim($file);
		//get version # based on zip file name
		$version = substr($filename,-5,1);

		$client = new rabbitMQClient("testRabbitMQ.ini","testServer");
                $request= array();
		$request['type'] = "changeStatus";
		$request['lvl'] = $lvl;
		$request['machine'] = $machineType;
		$request['version'] = $version ;
		$request['file'] = $filename;
		$request['status'] = trim($status);
                $response = $client->send_request($request);
		
		echo"$response".PHP_EOL;
		echo"initilizing next function....".PHP_EOL;
		sleep(5);
		// get the old working pkg filename from Table
		getOld($lvl,$machineType);
		
	}

function getOld($lvl,$machineType)
{

        echo"Ready to get Old Pkg...".PHP_EOL;
        //what was the last pkg that was working on Prod on FE/BE
        $client = new rabbitMQClient("testRabbitMQ.ini","Prod");
                $request= array();
                $request['type'] = "getOld";
                $request['lvl'] = $lvl;
                $request['machine'] = $machineType;

                $old = $client->send_request($request);

		//if there was no old working pkg..
		if ($old == "false")
		{echo"response is $old...".PHP_EOL;}

		if ($old == "false")
                {
                        $msg = "There was no previous working $lvl : $machineType version found";    
			echo"$msg".PHP_EOL;
			exit();
                }       
		else
		{
			$file = trim($old);
			//echo"The Old pkg name is $old".PHP_EOL;
			//get the old working pkg from Deploy VM
                	download_pkg($lvl,$machineType,$file);
		}
}

function download_pkg($lvl,$machineType,$file)
{

                echo"The old pkg that was working for $lvl $machineType was: $file".PHP_EOL;
                //ask Deploy for this old pkg
		exec("./getOld_pkg.sh $machineType $file");

		//make new function to update Status table that Prod is running new Pkg at the moment
}
?>
