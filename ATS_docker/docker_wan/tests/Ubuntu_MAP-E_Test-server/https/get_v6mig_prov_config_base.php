<?php
$USERNAME='_User-1';
$PASSWORD='Pass_word-1';

function auth($user,$pass) {
	global $USERNAME;
	global $PASSWORD;
	if ((!isset($user) || "$user" == "")
	 && (!isset($pass) || "$pass" == "")) {
		return "req";
	} elseif ($user == $USERNAME && $pass == $PASSWORD) {
		return "ok";
	} else {
		return "bad";
	}
}

$auth_result=auth($_GET['user'],$_GET['pass']);

$CONF_ORDER=array(<order>);

$order=array_map(
	function($v){return'"'.$v.'"';}, // quoting
	array_filter($CONF_ORDER, function($v){
		global $auth_result;
		return !empty($v) && ( $v != "ipip" || $auth_result == "ok" );
	}) // filter by auth
);

function print_auth() {
	global $CONF_ORDER;
	global $auth_result;
	if (in_array("ipip", $CONF_ORDER)) {
		return '"auth": "' . $auth_result . '",';
	} else {
		return '';
	}
}

?>
{
    "enabler_name": "<enabler_name>",
    "service_name": "<service_name>",
    "ttl": <ttl>,
    "token": "640756965820d3b9025b6941f9590af6802830ba58663fe8f043dc92b576f17a",
    <?=print_auth()?> 
    "order": [
        <?=implode(",",$order)?> 
    ],
    <param>
}
