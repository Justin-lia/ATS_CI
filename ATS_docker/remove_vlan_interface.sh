#!/bin/bash

source ./config.sh

sudo ip link delete ${ats_interface}.${lan_vlan_id}
sudo ip link delete ${ats_interface}.${wan_vlan_id}
sudo ip link delete ${ats_interface}.${backup_vlan_id}
