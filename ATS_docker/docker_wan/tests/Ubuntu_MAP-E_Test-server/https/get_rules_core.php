<?php
	function disp_rule_jsonp($rule_json_fn){
		$request = $_SERVER["REQUEST_URI"];
		$rule_json = trim(file_get_contents($rule_json_fn));
		$callback = (($pos1 = strpos($request,"callback"))===False)?"FALSE":(($pos2 = strpos($request."&","&"))===False)?"FALSE":substr($request."&", $pos1+9, $pos2-$pos1-9);
		if (strcmp($callback,"")==0) {
			$callback="?";
		}
		$rule_jsonp = $callback."(".$rule_json.");";
		echo $rule_jsonp;
	}

	function disp_rule_json($rule_json_fn){
		$rule_json = file_get_contents($rule_json_fn);
		echo $rule_json;
	}
	#Aterm WX5400HP は OCN-VC のルール先頭/末尾に空行が含まれていると接続失敗するようです.
	#NEC製品の動作確認の際は, 空行を含んだルールだと問題が起きる懸念があるため注意.
?>


