#!/bin/bash

DRUPALCONTAINER=`docker ps | awk '/drupal-1/ {print $1}'`

# set up modules
echo docker cp drupal_modules.sh ${DRUPALCONTAINER}:/drupal_modules.sh
docker cp drupal_modules.sh ${DRUPALCONTAINER}:/drupal_modules.sh
docker exec -it ${DRUPALCONTAINER} sh /drupal_modules.sh
