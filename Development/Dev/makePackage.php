#!/usr/bin/php
<?php
 	require_once('path.inc');
        require_once('get_host_info.inc');
	require_once('rabbitMQLib.inc');

//	global $argv;

	function chkV($machine)
	{
		echo "Getting last Version # for ".$machine."...".PHP_EOL;
		$client = new rabbitMQClient("testRabbitMQ.ini","testServer");

		$request= array();
		$request['type'] = "chkV";
		$request['machine'] = $machine;
		$response = $client->send_request($request);

		#check to see if you can get Version number as a variable here
		echo "Last Version number was $response ...\n";

		$newVerNum = $response+1;
	
		 return $newVerNum;
	}
	
	function doUpdate($nextV,$machine)
	{

		echo "Ready to update StatusTable...";
		$client = new rabbitMQClient("testRabbitMQ.ini","testServer");

		$myip = shell_exec("ifconfig enp0s3 | grep 'inet ' | awk '{print $2}' | cut -d/ -f1");
                $lvl = "Dev";
                $fname = $machine."_version_".$nextV.".zip";
                //echo "file name is: $fname  \n";

                $request            =   array();
                $request['type']    =   "updateTable";
                $request['ip']      =   trim($myip);
                $request['lvl']     =   $lvl;
                $request['machine'] =   $machine;
                $request['version'] =   $nextV;
                $request['filename']=   $fname;

		$response = $client->send_request($request);
		exit ;	
	}

	function makeNewVersion($machine)
	{
		//$client = new rabbitMQClient("testRabbitMQ.ini","testServer");
		
		$nextV = chkV($machine);
		echo"Our new Version Number is $nextV \n";
 		
		echo "Sending $nextV to Deploy... \n";
		//Zipping and Sending package to Deploy from bash script
		shell_exec("../package.sh $machine $nextV");
	
		echo "Updating DevTable in Deploy...\n";	
		//Updating Deploy table : DevTable
	 	$Update = doUpdate($nextV,$machine);
	
		echo "Developent stage complete...\n";
	}

	$ip = shell_exec("ifconfig enp0s3 | grep 'inet ' | awk '{print $2}' | cut -d/ -f1");
	echo "Your IP is: $ip";
	$machineType  = "";
	
		if (trim($ip) == "10.0.2.10"){

			$machineType = "FE";
		}		
		else{
		
			$machineType = "BE";
		}

		echo "Creating new Version for ".$machineType."\n";
		makeNewVersion($machineType);
?>
