#!/bin/bash
if [ $# -ne 1 ] ; then
        echo usage $0 Timestamp
        exit -1
fi

TS=$1

if [ -f site_${TS}.sql -a -f site_${TS}.tbz ] ; then
	DBCONTAINER=`docker ps | awk '/mariadb/ {print $1}'`
	echo docker cp site_${TS}.sql ${DBCONTAINER}:site_db_backup.sql
	docker cp site_${TS}.sql ${DBCONTAINER}:site_db_backup.sql
	echo docker exec ${DBCONTAINER} sh -c 'mysql --user=drupal --password=drupal drupal < /site_db_backup.sql'
	docker exec ${DBCONTAINER} sh -c 'mysql --user=drupal --password=drupal drupal < /site_db_backup.sql'

	DRUPALCONTAINER=`docker ps | awk '/drupal-1/ {print $1}'`
	echo docker cp site_${TS}.tbz ${DRUPALCONTAINER}:/site_drupal_files.tbz
	docker cp site_${TS}.tbz ${DRUPALCONTAINER}:/site_drupal_files.tbz
	echo docker exec -it ${DRUPALCONTAINER} tar -C /opt/drupal -xaf /site_drupal_files.tbz
	docker exec -it ${DRUPALCONTAINER} tar -C /opt/drupal -xaf /site_drupal_files.tbz
else
	echo no site_drupal_files to restore
fi
