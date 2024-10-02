#!/bin/bash

DBCONTAINER=`docker ps | awk '/mariadb/ {print $1}'`

docker exec ${DBCONTAINER} sh -c 'mysqldump --user=drupal --password=drupal drupal > /site_db_backup.sql'
docker cp ${DBCONTAINER}:site_db_backup.sql ./site_db_backup.sql


DRUPALCONTAINER=`docker ps | awk '/drupal-1/ {print $1}'`
docker exec -it ${DRUPALCONTAINER}  tar -C /opt/drupal -cjf /drupal.tbz .
docker cp ${DRUPALCONTAINER}:/drupal.tbz ./site_drupal_files.tbz

