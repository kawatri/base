#!/usr/bin/env bash

mkdir -p /home/hrazafia/data/db \
	/home/hrazafia/data/www/hrazafia.42.fr \
	/home/hrazafia/data/ssl/hrazafia.42.fr \
	/home/hrazafia/data/logs

docker compose up -d --build
