#!/bin/bash
cd docker_ats && docker compose down
cd ..
cd docker_lan && docker compose down
cd ..
cd docker_wan && docker compose down
cd ..

docker network prune -f
