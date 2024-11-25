#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
set -x

docker compose up -d

DRUPALCONTAINER=`docker ps | awk '/drupal-1/ {print $1}'`
docker exec -it ${DRUPALCONTAINER} /data/install_certs.sh

if [ -f data/config/DB.sql.gz -a -d data/config/sync -a -f data/config/files.tbz ] ; then
	echo 'reload previous site'
	# reload database
	
	docker exec -it $(docker ps | awk '/mariadb/ {print $1}') sh -c "/data/dbrestore.sh"

	# reload files
	# this contains files, settings, and composer.*
	docker exec -it ${DRUPALCONTAINER} sh -c "tar xaf /data/config/files.tbz ; composer install"
else
	echo 'initialize site'
	DRUPALCONTAINER=`docker ps | awk '/drupal-1/ {print $1}'`
	docker exec -it ${DRUPALCONTAINER} /data/setup.sh
	${SCRIPT_DIR}/backup.sh
fi
