<?php
	//ini_set("display_errors", 1);
	//error_reporting(E_ALL);
	ini_set("error_log", "/var/log/lighttpd/debug.log");

	//echo "[".date('Y-m-d H:i:s')."]"."PHP Test. PHP Test.";

	//error_log("[".date('Y-m-d H:i:s')."]"."PHP Test. PHP Test.");
	error_log(print_r($_POST,true));
?>


