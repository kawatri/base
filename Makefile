DOCKER_COMPOSE = srcs/docker-compose.yml

RM = rm -rf

DATABASE_VOLUME = /home/hrazafia/data/db
WEBSITE_VOLUME = /home/hrazafia/data/www/hrazafia.42.fr
LOGS_VOLUME = /home/hrazafia/data/logs
CERTS_VOLUME = /home/hrazafia/data/ssl/hrazafia.42.fr

VOLUME_LIST = $(DATABASE_VOLUME) $(WEBSITE_VOLUME) $(LOGS_VOLUME) $(CERTS_VOLUME)

all: up

up:
	mkdir -p $(VOLUME_LIST)
	docker compose -f $(DOCKER_COMPOSE) up -d --build

start:
	docker compose -f $(DOCKER_COMPOSE) start

stop:
	docker compose -f $(DOCKER_COMPOSE) stop

down:
	docker compose -f $(DOCKER_COMPOSE) down

clean: down
	docker volume rm $$(docker volume list -q)
	docker image rm $$(docker image list -aq)
	$(RM) $(VOLUME_LIST)

fclean: clean
	docker system prune --all --force

.PHONY: all up start stop down clean fclean
