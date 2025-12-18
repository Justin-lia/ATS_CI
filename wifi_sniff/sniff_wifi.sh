#!/bin/bash

#
# sniff_wifi.sh [interface] [bssid] [channel_freq]
#

if [ $# -lt 3 ]; then
    echo "Error : lost value！"
    echo "sniff_wifi.sh [interface] [bssid] [channel_freq]"
    echo "sniff_wifi.sh wlp2s0f0 4C:BA:7D:0F:2E:94 5520"
    exit 1
fi

# === 設定區 ===
#INTERFACE="wlp2s0f0"
#TARGET_MAC="4C:BA:7D:0F:2E:94" # 想要過濾的 MAC 地址
#CH_FREQ=5520              # 想要監聽的頻道 iw list 確認
INTERFACE=$1
TARGET_MAC=$2 # 想要過濾的 MAC 地址
CH_FREQ=$3              # 想要監聽的頻道 iw list 確認

DURATION=3                # 抓取秒數
SAVE_OUTPUT_TXT="wifi_filtered_$(date +%Y%m%d_%H%M%S).txt"
OUTPUT_TXT="sniff_wifi_pack.txt"

rm $OUTPUT_TXT

#type:0 (Management)
#subtype:,0x00 (0),Association Request
#	    ,0x04 (4),Probe Request
#	    ,0x05 (5),Probe Response
#	    ,0x08 (8),Beacon
#		,0x0b (11),Authentication
#		,0x0c (12),Deauthentication
#type:1 (Control)
#subtype:,0x0b (27),RTS
#		,0x0c (28),CTS
#		,0x0d (29),ACK
#type:2 (Data)
#subtype:,0x00 (0),Data
#		,0x08 (8),QoS Data
PACK_TYPE="0x00"	
PACK_SUBTYPE="0x08" #0x80=beacon

# 檢查 root 權限
if [[ $EUID -ne 0 ]]; then
   echo "請使用 sudo 執行此腳本"
   exit 1
fi

echo "--- 1. 準備網卡與設定頻道 $CHANNEL ---"
nmcli device set $INTERFACE managed no
ip link set $INTERFACE down
iw dev $INTERFACE set monitor control
ip link set $INTERFACE up
# 設定頻道 (BE200 支援 2.4/5/6GHz，請確保頻道與頻段對應)
iw dev $INTERFACE set freq $CH_FREQ

# 驗證狀態
echo "--- 2. Confirm WIFI interface is monitor mode ---"
MODE=$(iw dev $INTERFACE info | grep type | awk '{print $2}')
if [ "$MODE" != "monitor" ]; then
    echo "錯誤：無法切換至監控模式，請檢查驅動是否支援。"
    nmcli device set $INTERFACE managed yes
    exit 1
fi
echo "狀態確認：網卡已進入 $MODE 模式"

echo "--- 3. 開始抓取封包 (時間: $DURATION 秒) ---"
echo "過濾條件: MAC=$TARGET_MAC, 頻道=$CHANNEL, 類型=Beacon"

# --- Tshark 過濾語法說明 ---
# wlan.addr == $TARGET_MAC          : 過濾特定來源或目標 MAC
# wlan.fc.type_subtype == 0x08      : 0x08 代表 Beacon 封包
# (如果要抓 Data 封包，可用 wlan.fc.type == 2)
# -Y 是 Display Filter，-V 是詳細輸出，-l 是即時寫入

#timeout $DURATION tshark -i $INTERFACE -y IEEE802_11_RADIO \
#    -Y "wlan.addr == $TARGET_MAC && wlan.fc.type_subtype == $PACK_SUBTYPE" \
#	-c 2 \
#	-V -l > $OUTPUT_TXT

SUCCESS=false
MAX_RETRIES=5
for ((i=1; i<=MAX_RETRIES; i++))
do
    echo "第 $i 次嘗試抓取 Beacon (目標: $TARGET_MAC)..."
    
    # 執行抓包指令
    timeout $DURATION tshark -i $INTERFACE -y IEEE802_11_RADIO \
        -Y "wlan.addr == $TARGET_MAC && wlan.fc.type_subtype == $PACK_SUBTYPE" \
        -V -l > $OUTPUT_TXT 2>/dev/null

    # 檢查檔案是否不為空值 (-s 代表檔案存在且有內容)
    if [ -s "$OUTPUT_TXT" ]; then
        echo "成功：於第 $i 次嘗試抓到封包內容。"
        SUCCESS=true
        break
    else
        echo "警告：第 $i 次抓取失敗（空值）。"
        # 如果不是最後一次嘗試，就等待一下再重抓
        if [ $i -lt $MAX_RETRIES ]; then
            sleep 1
        fi
    fi
done

echo "--- 4. 恢復網卡 ---"
ip link set $INTERFACE down
iw dev $INTERFACE set type managed
ip link set $INTERFACE up
nmcli device set $INTERFACE managed yes

cp $OUTPUT_TXT $SAVE_OUTPUT_TXT
echo "抓取完成！結果已存至: $OUTPUT_TXT"
echo "抓取完成！結果已存至: $SAVE_OUTPUT_TXT"
