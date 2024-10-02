#!/bin/bash

if [ -f site_db_backup.sql ] ; then
	DBCONTAINER=`docker ps | awk '/mariadb/ {print $1}'`
	echo docker cp site_db_backup.sql ${DBCONTAINER}:site_db_backup.sql
	docker cp site_db_backup.sql ${DBCONTAINER}:site_db_backup.sql
	echo docker exec ${DBCONTAINER} sh -c 'mysql --user=drupal --password=drupal drupal < /site_db_backup.sql'
	docker exec ${DBCONTAINER} sh -c 'mysql --user=drupal --password=drupal drupal < /site_db_backup.sql'
else
	echo no site_db_backup.sql to restore
	exit -1
fi

if [ -f site_drupal_files.tbz ] ; then
	DRUPALCONTAINER=`docker ps | awk '/drupal-1/ {print $1}'`
	echo docker cp site_drupal_files.tbz ${DRUPALCONTAINER}:/site_drupal_files.tbz
	docker cp site_drupal_files.tbz ${DRUPALCONTAINER}:/site_drupal_files.tbz
	echo docker exec -it ${DRUPALCONTAINER} tar -C /opt/drupal -xaf /site_drupal_files.tbz
	docker exec -it ${DRUPALCONTAINER} tar -C /opt/drupal -xaf /site_drupal_files.tbz
else
	echo no site_drupal_files to restore
fi
