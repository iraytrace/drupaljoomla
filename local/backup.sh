#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
if [ $# -ge 1 ] ; then
SITE=$1
else
SITE=jcehdms
fi
echo ${SITE}

TS=$(date '+%Y_%m_%d_%H%M-%S')

DRUPAL=/c/xampp/htdocs/${SITE}
DEFAULT=${DRUPAL}/web/sites/default
BACKUP=${DRUPAL}/backup
STASH=/c/users/butler/Documents/src/drupaljoomla/local/data/${SITE}_${TS}
mkdir -p ${STASH}

export PATH=$PATH:${DRUPAL}/vendor/bin:/c/xampp/mysql/bin
cd ${DRUPAL}

# flush cache tables
echo "SHOW TABLES LIKE '%cache%'" | $(drush sql-connect) | tail -n +2 | \
	xargs -I% echo "TRUNCATE TABLE %;" | \
	$(drush sql-connect)

# export database
mysqldump.exe --user=drupal --password=drupal ${SITE} | gzip > ${STASH}/DB.sql.gz

# export configuration
mkdir -p ${STASH}/config

vendor/bin/drush config:export --destination=${STASH}/config --yes
cd -
tar -cjf ${STASH}/config.tbz -C ${STASH}  config
rm -rf ${STASH}/config

# export files
tar -cjf ${STASH}/files.tbz --exclude ${DEFAULT}/files/feeds/log -C ${DEFAULT} files

# stash settings.php
cp ${DEFAULT}/settings.php ${STASH}/settings.php


