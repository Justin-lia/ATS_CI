#!/bin/bash

# 檢查參數
if [ $# -lt 1 ]; then
    echo "用法："
    echo "  1. 列出該 SSID 的所有頻段資訊: $0 <SSID>"
    echo "  2. 列出該 SSID 中特定的 BSSID 資訊: $0 <SSID> <BSSID>"
    exit 1
fi

INTERFACE="wlp2s0f0"  # 請確認您的網卡名稱
TARGET_SSID=$1
TARGET_BSSID=$2

#echo "--- 正在全頻段掃描 SSID: $TARGET_SSID (含 MLO 2.4/5/6G) ---"

# 1. 執行掃描並格式化
# 使用 awk 的串列處理，確保不會漏掉重複 SSID 的不同 BSS
RAW_SCAN=$(sudo iw dev $INTERFACE scan | awk '
    /^BSS / { 
        bssid=$2; 
        gsub(/\(on/, "", bssid); 
    }
    /freq: / { freq=$2 }
    /SSID: / { 
        ssid=$0; 
        sub(/^[ \t]*SSID: /, "", ssid);
        if (ssid == "") ssid="[Hidden]";
        # 輸出格式：SSID BSSID FREQ
        printf "%s %s %s\n", ssid, bssid, freq
    }')

# 2. 判斷與輸出
if [ -z "$TARGET_BSSID" ]; then
    # 模式 1：顯示所有符合該 SSID 的 VAP (Virtual AP)
 #   echo "找到以下匹配項："
    echo "----------------------------------------------------------------"
    printf "%-25s %-20s %-10s %-10s\n" "SSID" "BSSID" "Freq(MHz)" "Band"
    echo "----------------------------------------------------------------"
    
    echo "$RAW_SCAN" | awk -v target="$TARGET_SSID" '
    $1 == target {
        band="2.4G";
        if ($3 > 5000) band="5G";
        if ($3 > 5900) band="6G";
        printf "%-25s %-20s %-10s %-10s\n", $1, $2, $3, band
    }'
else
    # 模式 2：指定 SSID + BSSID
#    echo "正在比對特定 BSSID..."
    echo "----------------------------------------------------------------"
    echo "$RAW_SCAN" | awk -v s="$TARGET_SSID" -v b="$TARGET_BSSID" '
    tolower($1) == tolower(s) && tolower($2) == tolower(b) {
        band="2.4G";
        if ($3 > 5000) band="5G";
        if ($3 > 5900) band="6G";
        printf "SSID: %-20s BSSID: %-20s Freq: %-10s Band: %s\n", $1, $2, $3, band
    }'
fi

# 3. 檢查是否完全沒結果
CHECK=$(echo "$RAW_SCAN" | awk -v s="$TARGET_SSID" '$1 == s' | wc -l)
if [ "$CHECK" -eq 0 ]; then
	echo "null"
#    echo "未搜尋到任何名為 \"$TARGET_SSID\" 的訊號。"
#    echo "請確認網卡是否已解鎖 6G 區域限制 (sudo iw reg set TW)。"
fi