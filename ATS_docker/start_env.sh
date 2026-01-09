#!/bin/bash

source ./config.sh

#export env_interface=${env_interface}

export env_ats_inet_mac=${env_ats_inet_mac}
export env_ats_lan_mac=${env_ats_lan_mac}
export env_ats_back_mac=${env_ats_back_mac}


export env_lan_lan_mac=${env_lan_lan_mac}
export env_lan_back_mac=${env_lan_back_mac}

export env_wan_wan_mac=${env_wan_wan_mac}
export env_wan_back_mac=${env_wan_back_mac}


#if [ ${ats_interface} = ${lan_interface} ]; then
if [ ${ats_interface} = ${lan_interface%.*} ]; then
	export env_backup_interface=${ats_interface}.${backup_vlan_id}
else
	export env_backup_interface=${ats_interface}
fi
export env_ats_interface=${ats_interface}
export env_lan_interface=${lan_interface}
export env_wan_interface=${wan_interface}

echo "host interface name"
echo "eth-inet binding host interface name: ${env_ats_interface}"
echo "eth-lan binding host interface name: ${env_lan_interface}"
echo "eth-back binding host interface name: ${env_ats_interface}"
echo "eth-wan binding host interface name: ${env_wan_interface}"


docker network create \
  --driver=macvlan \
  --subnet=192.168.100.0/24 \
  -o parent=${env_backup_interface} \
  env_net

echo "build env ats"
cd docker_ats
docker compose up -d
cd ..

echo "build env lan"
cd docker_lan
docker compose up -d
cd ..

echo "build env wan"
cd docker_wan
docker compose up -d

