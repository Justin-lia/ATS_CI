# 取得第一行並提取最後一個數字
grep "Maximum Number of Simultaneous Links" sniff_wifi_pack.txt | head -n 1 | awk -F': ' '{print $2}'
