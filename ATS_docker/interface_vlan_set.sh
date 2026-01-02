#!/bin/bash

source ./config.sh

# 1. 啟用網卡混雜模式 (Promiscuous mode)，讓它能接收非自己 MAC 的封包
sudo ip link set ${ats_interface} promisc on

# 2. 建立 VLAN 子介面 (這會產生 eth0.20, eth0.30, eth0.40)
# 注意：這只是暫時生效，重開機需重設，建議寫入 Netplan 永久生效
sudo ip link add link ${ats_interface} name ${ats_interface}.${lan_vlan_id} type vlan id ${lan_vlan_id}
sudo ip link add link ${ats_interface} name ${ats_interface}.${wan_vlan_id} type vlan id ${wan_vlan_id}
sudo ip link add link ${ats_interface} name ${ats_interface}.99 type vlan id 99

# 3. 啟動介面
sudo ip link set ${ats_interface}.${lan_vlan_id} up
sudo ip link set ${ats_interface}.${wan_vlan_id} up
sudo ip link set ${ats_interface}.99 up
