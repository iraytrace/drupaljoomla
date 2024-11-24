#!/bin/bash

if [ $# -lt 2 ] ; then
	echo "Usage: $0 destination_path user"
	echo "  example: $0 /data/2024_11_14_12_15_32 user"
	exit 1
fi

DRUPAL=/opt/drupal
DEFAULT=${DRUPAL}/web/sites/default

# backup site configuration to config.tbz
drush config:export --yes

tar xjf $1/files.tbz -C ${DRUPAL} files
chown $2 /data/site.tbz

# extract settings.php
install -o $2 -m 0644 ${DEFAULT}/settings.php $1/settings.php
