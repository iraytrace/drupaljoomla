#!/bin/bash
#

docker rm -vf $(docker images -aq)
docker rmi -vf $(docker images -aq)
docker compose up --build
