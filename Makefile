include .env

run: build 
	./bin/${BINARY}

stop:
	@-pkill -SIGTERM -f "./bin/${BINARY}"

build:
	go build -o ./bin/${BINARY} cmd/server/*.go

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
 
create_migrations:
	migrate create -ext sql -dir internal/db/migrations -seq init

migrate_up:
	migrate -database "postgres://${DB_USER}:${DB_PASSWORD}@${DB_HOST}:${DB_PORT}/${DB_NAME}?sslmode=disable" -path internal/db/migrations up

migrate_down:
	migrate -database "postgres://${DB_USER}:${DB_PASSWORD}@${DB_HOST}:${DB_PORT}/${DB_NAME}?sslmode=disable" -path internal/db/migrations down
