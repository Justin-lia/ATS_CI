docker network create \
  --driver=macvlan \
  --subnet=192.168.100.0/24 \
  -o parent=enp3s0f1.99 \
  env_net
