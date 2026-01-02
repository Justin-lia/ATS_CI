*** Variables ***
${URL_Extender}    http://192.168.100.100/
${LAN_IP}    192.168.1.1
${URL}      http://${LAN_IP}/
${LAN_Netmask}    255.255.255.0
${DUT_Password}    admin
${Product_Name}    WREQ-130BE
${Copyright_info}
${NTP_Server}
${ATS_to_DUT_Interface}    enp6s0
${Port_Number_Clear}    37
${Console_Port_Number_Clear}    39
${Cisco_LAN_Switch_Port_Number_Clear}    34
${ipv6_DUT_MAC}    :cc20
${ipv6_LAN_PC_MAC}    :350f
${DUT_WAN_Linklocal_IP}    fe80::4eba:7dff:fec7:cc20
${DUT_LAN_MAC}    4C:BA:7D:C7:CC:21
${LAN_PC_MAC}    00:0a:cd:47:35:0f
${Wireless_PC_MAC}    d4:f3:2d:c7:dd:1e
${Agent_Interface_on_cisco_switch}    GigabitEthernet 1/0/14
${DUT_WAN_Interface_on_cisco_switch}    GigabitEthernet 1/0/3
${Platform}    'SPF13'

#-----------------------------WiFi
${WPS_bssid_2G}    4C:BA:7D:C7:CC:22
${WPS_bssid_5G}    4C:BA:7D:C7:CC:23
${WPS_PIN_Code}    56473812
${WirelessPC1_telnet_Profile}    Wired connection 1.nmconnection
${WirelessPC2_telnet_Profile}    Wired connection 1.nmconnection

#-----------------------------FW Update
${Path_for_FW_Update_production}    /home/vagrant/Downloads/FW/WREQ-130BE.v2-v1.0.02.026.bin
${Path_for_FW_Update}    /home/vagrant/Downloads/FW/WREQ-130BE.v2-v1.0.02.026.bin
${Expect_FW_Version}    1.0.02.026
${Path_for_Old_FW}    /home/vagrant/Downloads/FW/WREQ-130BE.v2-v1.0.02.024.bin
${other_Linksys_model_FW}    /home/vagrant/Downloads/FW/wrongFW/WSR-1166DHP3_v116r1722_CRC_fw_JP.bin
${other_regions_FW}    /home/vagrant/Downloads/FW/WSR-1166DHP3_v116r1722_CRC_fw_JP.bin
${Config_File_for_FW_Update}    ap_dhp4.txt
${Path_for_FW_Downgrade}    /home/vagrant/Downloads/FW/WREQ-130BE.v2-v1.0.02.024.bin
${Expect_FW_Version_Downgrade}    1.0.02.024

#-----------------------------------------------

#-----------------------------TestLink
${testlink_url}    http://10.5.88.108/lib/api/xmlrpc/v1/xmlrpc.php
${testlink_key}    036f84b4dd605a9ccd16af029493ee4b
${platformid}    9
${testplanid}    30439
${buildid}    38

#--Justin update---------------------------------------------
${COM_PORT}    COM3    
${baudrate_value}    115200
${IFACE}       wlp3s0f0
${Client_PASSWORD}    password
${conf_PATH}   /etc/wpa_supplicant/wpa_supplicant.conf
${conf_wpa3_PATH}   /etc/wpa_supplicant/wpa_supplicant_wpa3.conf
${Config_name}    test.conf
${TIMEOUT}     10
${Count_Number}    0
${total_unable_to_get_value_from_USP}    0
${total_get_value_from_USP}    0
${wait_counter}        0
${dynamic_value}        0
${TMP_CONF}    test_tmp.conf
${ORIG_CONF}    /etc/wpa_supplicant/wpa_supplicant.conf
${TMP1_CONF}    test_tmp1.conf
${ORIG_wpa3_CONF}    /etc/wpa_supplicant/wpa_supplicant_wpa3.conf
${TMP1_wpa3_CONF}    test_wpa3_tmp1.conf
${GUI_IP}    192.168.1.1
##---telnet buffalo console-----
${Switch_HOST}    127.0.0.1
${Switch_PORT}    9998
##---SSH-----
${HOST}     192.168.1.1
${USER}     root
${SSH_PASSWORD}    
${CMD}      ifconfig
##---DUT SSID---
${Default_PSK}    
#${Default_PSK}    4cba7d0291ed
${Changed_PSK}    12345678
${Changed_SSID}    AUTOmeshTEST
${Changed_SSID_PSK}    123456789012345678901234567890121234567890123456789012345678901
${Changed_2G_SSID}    AUTOWiFiBasic_2G_123456789012345
${Changed_5G_SSID}    AUTOWiFiBasic_5G_123456789012345
${Changed_6G_SSID}    AUTOWiFiBasic_6G_123456789012345