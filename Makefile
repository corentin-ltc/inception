DOCKER_COMPOSE = srcs/docker-compose.yml

all: up

up:
	docker-compose -f $(DOCKER_COMPOSE) up --build

down:
	docker-compose -f $(DOCKER_COMPOSE) down

fclean:
	docker container prune -f
	docker system prune -af
	docker volume rm -f srcs_mariadb
	docker volume rm -f srcs_wordpress
	@docker volume rm $(docker volume ls -q --filter dangling=true) 2>/dev/null || true

re: fclean all

.PHONY: all up down fclean re