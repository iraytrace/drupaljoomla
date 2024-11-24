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
STASH=/c/users/butler/Documents/src/drupaljoomla/local/data/${SITE}
if [ ! -d ${STASH} ] ; then
	mkdir -p ${STASH}
fi

export PATH=$PATH:${DRUPAL}/vendor/bin:/c/xampp/mysql/bin

# export database
mysqldump.exe --user=drupal --password=drupal ${SITE} > ${STASH}/DB.sql

cd ${DRUPAL}
vendor/bin/drush config:export --yes

# export files
tar -cjf ${STASH}/files.tbz --exclude ${DEFAULT}/files/feeds/log -C ${DEFAULT} files

# stash settings.php
cp ${DEFAULT}/settings.php ${STASH}/settings.php


