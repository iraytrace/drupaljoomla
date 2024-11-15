#!/bin/bash

DBCONTAINER=`docker ps | awk '/mariadb/ {print $1}'`
DRUPALCONTAINER=`docker ps | awk '/drupal-1/ {print $1}'`
TS=$(date '+%Y_%m_%d_%H%M-%S')

mkdir -p data/${TS}
	
USERID=$(id -u) 

# save the database
docker exec ${DBCONTAINER} sh -c "mysqldump --user=drupal --password=drupal drupal | bzip2 > /data/${TS}/DB.sql.bz ; chown $USERID /data/${TS}/DB.sql.bz"

# save the drupal data and files
docker exec -it ${DRUPALCONTAINER}  sh -c "/data/export.sh /data/${TS} $USERID"

