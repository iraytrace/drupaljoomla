#!/bin/bash

docker compose up -d
docker exec -it $DRUPALCONTAINER /data/install_certs.sh

DRUPALCONTAINER=`docker ps | awk '/drupal-1/ {print $1}'`

if [ -f data/config/DB.sql.gz -a -d data/config/sync -a -f /data/config/settings.php ] ; then
	# reload
	DBCONTAINER=`docker ps | awk '/mariadb/ {print $1}'`
	docker exec -it ${DBCONTAINER} sh -c "gunzip < /data/config/DB.sql.gz | mysql --user=drupal --password=drupal drupal"
	docker exec -it ${DRUPALCONTAINER} sh -c "cp /data/config/settings.php web/sites/default/settings.php"

else
	DRUPALCONTAINER=`docker ps | awk '/drupal-1/ {print $1}'`
	docker exec -it ${DRUPALCONTAINER} /data/setup.sh
fi
