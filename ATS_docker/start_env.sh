docker network create \
  --driver=macvlan \
  --subnet=192.168.100.0/24 \
  -o parent=enp3s0f1.99 \
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

