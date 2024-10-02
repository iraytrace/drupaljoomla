#!/bin/bash

docker compose up -d

DRUPALCONTAINER=`docker ps | awk '/drupal-1/ {print $1}'`

# set up modules
echo docker cp drupal_modules.sh ${DRUPALCONTAINER}:/drupal_modules.sh
docker cp drupal_modules.sh ${DRUPALCONTAINER}:/drupal_modules.sh
docker exec -it ${DRUPALCONTAINER} sh /drupal_modules.sh

echo copy initial content out
docker exec -it ${DRUPALCONTAINER} tar -C /opt/drupal -cjf /dump.tbz .
docker cp ${DRUPALCONTAINER}:/dump.tbz initial.tbz
