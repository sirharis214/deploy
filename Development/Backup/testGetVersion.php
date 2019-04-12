#!/usr/bin/php
<?php

 	require_once('path.inc');
        require_once('get_host_info.inc');
	require_once('rabbitMQLib.inc');
	
	$bzid = "2";
	function test($bzid)
	{

		echo "running test to get username from BackEnd \n";
		$client = new rabbitMQClient("testRabbitMQ.ini","testServer");

                $request = array();
                $request['type'] = "test";
		$request['bzid'] = $bzid;

		$response = $client->send_request($request);
		
		echo "response is : $response \n";
	}

	test($bzid);
?>
