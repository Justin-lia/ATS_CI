<?php
	require "get_rules_core.php";
	disp_rule_json("./get_rules_ocn_normal.json");
	#Aterm WX5400HP は OCN-VC のルール先頭/末尾に空行が含まれていると接続失敗するようです.
	#NEC製品の動作確認の際は, 空行を含んだルールだと問題が起きる懸念があるため注意.
?>
