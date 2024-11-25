#!/bin/bash

DRUPALCONTAINER=`docker ps | awk '/drupal-1/ {print $1}'`

mkdir -p data/config
	
USERID=$(id -u) 

# save the drupal data and files
docker exec -it ${DRUPALCONTAINER}  sh -c "/data/backup.sh $USERID"

