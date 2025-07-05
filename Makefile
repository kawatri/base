NAME = Inception

DOCKER_COMPOSE_FILE = srcs/docker-compose.yml

RM = rm -f

DATABASE_VOLUME = /home/hrazafia/data/db
WEBSITE_VOLUME = /home/hrazafia/data/www/hrazafia.42.fr
LOGS_VOLUME = /home/hrazafia/data/logs
CERTS_VOLUME = /home/hrazafia/data/ssl/hrazafia.42.fr

VOLUME_LIST = $(DATABASE_VOLUME) $(WEBSITE_VOLUME) \
  $(LOGS_VOLUME) $(CERTS_VOLUME)

all: $(NAME)

$(NAME):
	$(MAKE) up
	touch Inception

up:
	mkdir -p $(VOLUME_LIST)
	docker compose -f $(DOCKER_COMPOSE_FILE) up -d --build

down:
	docker compose -f $(DOCKER_COMPOSE_FILE) down

start:
	docker compose -f $(DOCKER_COMPOSE_FILE) start

stop:
	docker compose -f $(DOCKER_COMPOSE_FILE) stop

status:
	docker compose -f $(DOCKER_COMPOSE_FILE) ps

clean: down
	$(RM) Inception
	docker volume rm $$(docker volume list -q)
	docker image rm $$(docker image list -aq)
	$(RM) -r $(VOLUME_LIST)

fclean: clean
	docker system prune --all --force

re: fclean all

.PHONY: all up down start stop status clean fclean re
