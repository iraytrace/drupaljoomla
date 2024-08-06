#!/bin/bash
#

echo DRUPAL_CONTEXT=${PWD}/drupal > .env
#docker rm -vf $(docker images -aq)
#docker rmi -vf $(docker images -aq)
docker compose up --build
