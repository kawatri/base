#!/usr/bin/env bash

docker compose down
docker volume rm $(docker volume list -q)
docker image rm $(docker image list -aq)
rm -rf /home/hrazafia/data
