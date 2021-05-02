# author: Giuseppe Caliendo

# Variables
.DEFAULT_GOAL := help

# Normalize goals
all: up down
.PHONY: all

##help:	@ List available tasks on this project
help:
	@fgrep -h "##" $(MAKEFILE_LIST)| sort | fgrep -v fgrep | tr -d '##'  | awk 'BEGIN {FS = ":.*?@ "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

##up: @ Start the local container 
up:
	docker-compose up -d

##down: @ Stop the local container 
down:
	docker-compose down
