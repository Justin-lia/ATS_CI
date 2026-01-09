#!/bin/bash

# --- Auto-update and Logic Check ---
if [ "$#" -eq 2 ]; then
    key=$1
    value=$2

    # 1. Check if ats_interface contains a "." (VLAN ID not allowed)
    if [ "$key" == "ats_interface" ] && [[ "$value" == *"."* ]]; then
        echo "Error: ats_interface cannot contain a VLAN ID (e.g., .20)"
        exit 1
    fi

    # 2. Logic for lan_interface / wan_interface sync
    if [[ "$key" =~ ^(lan|wan)_interface$ ]] && [[ "$value" == *"."* ]]; then
        # Extract VLAN ID (content after the dot)
        vid="${value##*.}"
        
        # Update the interface with the full string (e.g., enp3s0.20)
        sed -i "s/^${key}=['\"].*['\"]/${key}='${value}'/" "$0"
        
        # Automatically sync the corresponding vlan_id variable
        vlan_key="${key%_interface}_vlan_id"
        sed -i "s/^${vlan_key}=['\"].*['\"]/${vlan_key}='${vid}'/" "$0"
        
        echo "Updated ${key} to '${value}' and synced ${vlan_key} to '${vid}'"
        exit 0
    fi

    # Standard update logic for other variables
    sed -i "s/^${key}=['\"].*['\"]/${key}='${value}'/" "$0"
    echo "Updated ${key} to '${value}'"
    exit 0
fi

# --- Configuration Values ---
# These lines are dynamically modified by the sed commands above
env_ats_inet_mac='02:42:ac:11:00:01'
env_ats_lan_mac='02:42:ac:11:00:02'
env_ats_back_mac='02:42:ac:11:00:03'

env_lan_lan_mac='02:42:ac:11:00:04'
env_lan_back_mac='02:42:ac:11:00:05'

env_wan_wan_mac='02:42:ac:11:00:06'
env_wan_back_mac='02:42:ac:11:00:07'

ats_interface='enp3s0f1'
lan_interface='enp3s0f1.20'
wan_interface='enp3s0f1.30'
lan_vlan_id='20'
wan_vlan_id='30'
backup_vlan_id='99'
