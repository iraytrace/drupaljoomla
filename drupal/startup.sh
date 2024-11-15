#!/bin/bash

docker compose up -d

DRUPALCONTAINER=`docker ps | awk '/drupal-1/ {print $1}'`
docker exec -it $DRUPALCONTAINER /data/install_certs.sh
docker exec -it $DRUPALCONTAINER /data/drupal_modules.sh

