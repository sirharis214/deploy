#!/usr/bin/php
<?php

 	require_once('path.inc');
        require_once('get_host_info.inc');
        require_once('rabbitMQLib.inc');

$machine = exec('../getSend.sh');

echo "machine is: ".$machine."\n";
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
	
	echo "Filename is: ".$file."\n";
	sendFile($machine,$file);
}

function sendFile($machine,$file)
{
	shell_exec("../doSend.sh $machine $file");
}
?>
