#!/bin/bash

DBCONTAINER=`docker ps | awk '/mariadb/ {print $1}'`

mkdir -p data/config
	
USERID=$(id -u) 

# save the database
docker exec ${DBCONTAINER} sh -c "mysqldump --user=drupal --password=drupal drupal | gzip > /data/config/DB.sql.gz ; chown $USERID:$USERID /data/config/DB.sql.gz"
