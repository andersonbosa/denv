# The .PHONY target indicates that the keys are phony targets, meaning they
# don't represent real files and will always be executed.
.PHONY: all build run

# Source the environment variables from scripts/.denv
include .denv

build:
	docker compose build

up:
	docker compose up

down:
	docker compose down

logs:
	docker compose logs -f

run:
	up logs

setup:
	docker network create denv-proxy
