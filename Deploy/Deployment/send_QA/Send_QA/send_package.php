#!/usr/bin/php
<?php

 	require_once('path.inc');
        require_once('get_host_info.inc');
        require_once('rabbitMQLib.inc');

$machine = exec('../getSend.sh');

echo "Preparing to send to QA ".$machine."\n";

//start funtion to get file that we have to send to QA
getFile($machine);

//Get file name for the last version sent by Development
function getFile($machine)
{
	$client = new rabbitMQClient("testRabbitMQ.ini","testServer");
                
	$request= array();
        $request['type'] = "getFile";
        $request['machine'] = $machine;
        
	$file = $client->send_request($request);
	$version = substr($file,-5,1);

        echo "The Latest Pkg Developers worked on was Version #:".$version."  $file \n";

	sendFile($machine,$file,$version);
}

function sendFile($machine,$file,$version)
{
	echo "Sending $file to QA...\n";
	shell_exec("../doSend.sh $machine $file");
	doUpdate($machine,$file,$version);
	
}

function doUpdate($machine,$file,$version)
{
	//You are sending a pkg to QA...
	//Track this by updating StatusTable

	echo "Updating StatusTable in Deploy...\n";
	$client = new rabbitMQClient("testRabbitMQ.ini","testServer");

        $request= array();
        $request['type'] = "update_sent";
        $request['lvl']  = 'QA';
	$request['machine'] = $machine;
	$request['version']  = $version;
	$request['status']  = "Pending";
	$request['filename'] = $file;

        $response = $client->send_request($request);
	echo "Done sending & updating QA with new Package...\n";
	exit();
}

?>
