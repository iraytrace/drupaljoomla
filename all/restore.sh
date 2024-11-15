#!/bin/bash
if [ $# -ne 1 ] ; then
        echo usage $0 directory
		echo example: $0 data/2024_01_01_2130-33
	   exit -1
fi

TS=$(basename $1)
DBCONTAINER=`docker ps | awk '/mariadb/ {print $1}'`
DRUPALCONTAINER=`docker ps | awk '/drupal-1/ {print $1}'`

# restore database
docker exec ${DBCONTAINER} sh -c "bzip2 -d < /data/${TS}/DB.sql.bz | mysql --user=drupal --password=drupal drupal"

# restore drupal configuration
docker exec ${DRUPALCONTAINER} sh -c "/data/import.sh /data/${TS}"
