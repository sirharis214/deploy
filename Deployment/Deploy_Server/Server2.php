#!/usr/bin/php
<?php
require_once('path.inc');
require_once('get_host_info.inc');
require_once('rabbitMQLib.inc');

function getV($machine)
{
	$db = mysqli_connect("localhost","user1","user1pass","deploy");
	$statement = "SELECT MAX(version) FROM DevTable WHERE type = '$machine'";
	
	$runQ = mysqli_query($db,$statement);
	$queryBack = mysqli_num_rows($runQ);
	if (!$db){ die("mysql connection failed: ".mysqli_connect_error());}
	else
	{
		if ($queryBack > 0 )
		{
			$Varray = mysqli_fetch_array($runQ);
			$version = $Varray[0];
        		echo"Version Num is : $version".PHP_EOL;
        		return $version;
		}
		else 
		{
			$msg = "There is no version for this machine";
			return $msg;
		}
	}
}

function doTest($bzid)
{
	$db = mysqli_connect("localhost","user1","user1pass","test");
	echo "received Request FOR Test".PHP_EOL;
	$que = "SELECT username FROM testTable WHERE bzid = '$bzid'";
        $Q = mysqli_query($db,$que);
	
	$ans = mysqli_fetch_array($Q);	
	$uname = $ans['username'];
	echo"username is : $uname".PHP_EOL;
	return $uname;

}

function requestProcessor($request)
{
  	echo "received request".PHP_EOL;
	var_dump($request);

  	if(!isset($request['type']))
  	{
    	 return "ERROR: unsupported message type";
 	}
  	switch ($request['type'])
  	{
	case "chkV":
		return getV($request['machine']);
	case "test":
		return doTest($request['bzid']);
	case "validate_session":
		return doValidate($request['sessionId']);
	}
	return array("returnCode" =>'0', 'message'=>"Server received request and processed");
}

$server = new rabbitMQServer("testRabbitMQ.ini","testServer");

$server->process_requests('requestProcessor');
exit();

?>
