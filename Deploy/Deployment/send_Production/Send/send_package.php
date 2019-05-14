#!/usr/bin/php
<?php

 	require_once('path.inc');
        require_once('get_host_info.inc');
        require_once('rabbitMQLib.inc');

$machine = exec('../getSend.sh');

echo "Preparing to send to Prod ".$machine."\n";
//start funtion to get file that we have to send to Production
getProd($machine);

//Get file name for the last version sent by Development
function getProd($machine)
{
	$client = new rabbitMQClient("testRabbitMQ.ini","testServer");
                
	$request= array();
        $request['type'] = "getProd";
        $request['machine'] = $machine;
        
	$file = $client->send_request($request);
	$version = substr($file,-5,1);

        echo "Ready to move Version ".$version." to Production\n";
	#echo "Filename is: ".$file."\n";
	sendFile($machine,$file,$version);
}

function sendFile($machine,$file,$version)
{
	echo"Sending Version: $version File: $file  to Prod $machine...\n";
	shell_exec("../doSend.sh $machine $file");
	echo "Done sending...\n";
	doUpdate($machine,$file,$version);
	
}

function doUpdate($machine,$file,$version)
{
	//You are sending a pkg to Production...
	//Track this by updating StatusTable

	echo "Updating StatusTable in deploy...\n";
	$client = new rabbitMQClient("testRabbitMQ.ini","testServer");

        $request= array();
        $request['type'] = "update_sent";
        $request['lvl']  = 'Prod';
	$request['machine'] = $machine;
	$request['version']  = $version;
	$request['status']  = "good";
	$request['filename'] = $file;

        $response = $client->send_request($request);
	echo "Done updating....\n";
	echo "Finished moving Version $version to Production...\n";
	exit();
}

?>
