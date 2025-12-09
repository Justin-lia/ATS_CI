<?php
	$request = $_SERVER["REQUEST_URI"];
	$report_json = file_get_contents("./acct_report.json");
	$callback = (($pos1 = strpos($request,"callback"))===False)?"FALSE":(($pos2 = strpos($request."&","&"))===False)?"FALSE":substr($request."&", $pos1+9, $pos2-$pos1-9);
	$report_jsonp = $callback."(".$report_json.");";

	echo $report_jsonp;
?>


