#!/usr/bin/php
<?php

 	require_once('path.inc');
        require_once('get_host_info.inc');
	require_once('rabbitMQLib.inc');

	global $argv;

	function chkV($machine)
	{
		echo "Getting last Version # for ".$machine.PHP_EOL;
		$client = new rabbitMQClient("testRabbitMQ.ini","testServer");
		$request= array();
		$request['type'] = "chkV";
		$request['machine'] = $machine;
		$response = $client->send_request($request);

		#check to see if you can get Version number as a variable here
		echo"Last Version number is $response \n";

		$newVerNum = $response+1;
	
		 return $newVerNum;
	}

	function makeNewVersion($machine)
	{
		$client = new rabbitMQClient("testRabbitMQ.ini","testServer");
		
		$nextV = chkV($machine);
		echo"Our new Version Number is $nextV \n";
		shell_exec("../package.sh $machine $nextV");
	}

	$ip = shell_exec("ifconfig enp0s3 | grep 'inet ' | awk '{print $2}' | cut -d/ -f1");
	echo "Your IP is: $ip";
	
		if ($ip = "10.0.2.20")
		{
			$machineType = "FE";
		}
		elseif ($ip = "10.0.2.21")
		{
			$machineType = "BE";
		}

		echo "Creating new Version for ".$machineType."\n";
		makeNewVersion($machineType);
?>
