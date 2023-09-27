include .env

create_db:
	docker exec -it ${DB_DOCKER_CONTAINER} createdb --username=${DB_USER} --owner=${DB_USER} ${DB_NAME}

create_container:
	docker run --name ${DB_DOCKER_CONTAINER} -p 5432:5432 -e POSTGRES_USER=${DB_USER} -e POSTGRES_PASSWORD=${DB_PASSWORD} -d postgres:12-alpine

start_container:
	docker start ${DB_DOCKER_CONTAINER}

stop_container:
	if [ $$(docker ps -q) ]; then \
		echo "\nContainers found and stopped"; \
		docker stop $$(docker ps -q); \
	else \
		echo "\nThere are no containers running..."; \
	fi
 