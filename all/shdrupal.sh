#!/bin/bash
DRUPALCONTAINER=`docker ps | awk '/drupal-1/ {print $1}'`
docker exec -it ${DRUPALCONTAINER} bash
