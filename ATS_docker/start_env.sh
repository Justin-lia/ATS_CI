#!/bin/bash

source ./config.sh

cp ./config.sh ./docker_ats/tests/
cp ./fix_interface_name_ats.sh ./docker_ats/tests/

cp ./config.sh ./docker_wan/tests/
cp ./fix_interface_name_wan.sh ./docker_wan/tests/

cp ./config.sh ./docker_lan/tests/
cp ./fix_interface_name_lan.sh ./docker_lan/tests/


#export env_interface=${env_interface}

export env_ats_inet_mac=${env_ats_inet_mac}
export env_ats_lan_mac=${env_ats_lan_mac}
export env_ats_back_mac=${env_ats_back_mac}
export env_ats_interface=${ats_interface}

export env_lan_lan_mac=${env_lan_lan_mac}
export env_lan_back_mac=${env_lan_back_mac}
export env_lan_interface=${ats_interface}.${lan_vlan_id}

export env_wan_wan_mac=${env_wan_wan_mac}
export env_wan_back_mac=${env_wan_back_mac}
export env_wan_interface=${ats_interface}.${wan_vlan_id}

docker network create \
  --driver=macvlan \
  --subnet=192.168.100.0/24 \
  -o parent=${env_ats_interface}.99 \
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

