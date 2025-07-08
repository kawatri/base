NAME			= .Inception

DOCKER_COMPOSE_FILE	= srcs/docker-compose.yml
VOLUME_DIRECTORY	= /home/hrazafia/data

DATABASE_VOLUME		= /home/hrazafia/data/db
WEBSITE_VOLUME		= /home/hrazafia/data/www/hrazafia.42.fr
LOGS_VOLUME		= /home/hrazafia/data/logs
CERTS_VOLUME		= /home/hrazafia/data/ssl/hrazafia.42.fr

RM			= rm -f
UP			= up -d --build

VOLUME_LIST		= $(DATABASE_VOLUME) $(WEBSITE_VOLUME) \
			  $(LOGS_VOLUME) $(CERTS_VOLUME)

all: $(NAME)

$(NAME):
	$(MAKE) up
	touch $(NAME)

up:
	sudo mkdir -p $(VOLUME_LIST)
	docker compose -f $(DOCKER_COMPOSE_FILE) $(UP)

down:
	$(RM) $(NAME)
	docker compose -f $(DOCKER_COMPOSE_FILE) down

start:
	docker compose -f $(DOCKER_COMPOSE_FILE) start

stop:
	docker compose -f $(DOCKER_COMPOSE_FILE) stop

status:
	docker compose -f $(DOCKER_COMPOSE_FILE) ps

clean: down
	sudo $(RM) -r $(VOLUME_DIRECTORY)
	docker image rm $$(docker image list -aq)
	docker volume rm $$(docker volume list -q)

fclean: clean
	docker system prune --all --force

re: clean all

.PHONY: all up down start stop status clean fclean re
