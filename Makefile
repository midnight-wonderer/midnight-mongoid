SHELL=/usr/bin/env bash

start: up

.PHONY: build up down bash

build:
	docker-compose build --pull application

down:
	docker-compose down

up:
	docker-compose up application

bash:
	(docker-compose run --rm application bash) || true
