#!/bin/bash

if [ $# -lt 1 ] ; then
	echo "Usage: $0 path"
	echo "  example: $0 /data/2024_11_14_12_15_32"
	exit 1
fi

DRUPAL=/opt/drupal
DEFAULT=${DRUPAL}/web/sites/default
BACKUP=${DRUPAL}/backup

rm -rf ${BACKUP}
mkdir -p ${BACKUP}


# restore settings.php
install -m 0444 $1/settings.php ${DEFAULT}/settings.php

# restore files
tar -C ${DEFAULT} -xaf $1/files.tbz 

# restore configuration
tar -C ${BACKUP} -xaf $1/config.tbz 
drush config:import --source=${BACKUP}/config --yes
