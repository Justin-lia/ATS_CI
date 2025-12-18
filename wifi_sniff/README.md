apt-get install -y tshark
WIFI Interface = Intel BE200
    # lshw -c network
	# configuration: broadcast=yes driver=iwlwifi driverversion=6.14.0-33-generic firmware=96.44729d4e.0 gl-c0-fm-c0-96.uc latency=0 link=no multicast=yes
sniff_wifi.sh
	the script will:
		1. setup wifi interface to "monitor" mode and the setup channel
		2. Confirm wifi inteface is monitor mode
		3. Execute sniff pack (time : default 3 s)
		   When sniff pack is null will retry 5 times
		   log save to "sniff_wifi_pack.txt"
		4. Restore wifi interface to manager mode
		6. copy sniff_wifi_pack.txt to wifi_filtered_$(date +%Y%m%d_%H%M%S).txt
	how to use:
		sniff_wifi.sh [interface] [bssid] [channel_freq]
	Sample 
		sniff_wifi.sh wlp2s0f0 4C:BA:7D:0F:2E:94 5520
	Output:
		sniff_wifi_pack.txt
		wifi_filtered_$(date +%Y%m%d_%H%M%S).txt

grep_Maximum_Number_Of_Simultaneous_Links.sh
	grep "Maximum Number of Simultaneous Links" sniff_wifi_pack.txt | head -n 1 | awk -F': ' '{print $2}'
	
ssid_scan.sh
	Script:
		1.Grep scan ssid display bssid freq(channel) band
	how to use:
		ssid_scan.sh [SSID]
		ssid_scan.sh [SSID] [BSSID]
	Output:
		./ssid_scan.sh Gemtek_Wi-Fi7_0F2E90
		----------------------------------------------------------------
		SSID                      BSSID                Freq(MHz)  Band
		----------------------------------------------------------------
		Gemtek_Wi-Fi7_0F2E90      4c:ba:7d:0f:2e:94    5520.0     5G


	