#!/bin/bash

if [ $# -lt 2 ] ; then
	echo "Usage: $0 destination_path user"
	echo "  example: $0 /data/2024_11_14_12_15_32 user"
	exit 1
fi

DRUPAL=/opt/drupal
DEFAULT=${DRUPAL}/web/sites/default
BACKUP=${DRUPAL}/backup

# backup site configuration to config.tbz
rm -rf ${BACKUP}
mkdir -p ${BACKUP}/config
drush config:export --destination=${BACKUP}/config --yes
tar cjf ${BACKUP}/config.tbz -C ${BACKUP} config
install -o $2 -m 0644 ${BACKUP}/config.tbz $1/config.tbz

# extract settings.php
install -o $2 -m 0644 ${DEFAULT}/settings.php $1/settings.php

# save files
tar cjf ${BACKUP}/files.tbz --exclude ${DEFAULT}/files/feeds/log -C ${DEFAULT} files
install -o $2 -m 0644 ${BACKUP}/files.tbz $1/files.tbz
