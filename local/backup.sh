#!/bin/bash


TS=$(date '+%Y_%m_%d_%H%M-%S')


DRUPAL=/c/xampp/htdocs/jcehdms
DEFAULT=${DRUPAL}/web/sites/default
BACKUP=${DRUPAL}/backup
STASH=/c/users/butler/Documents/src/drupaljoomla/local/jcehdms/${TS}
mkdir -p ${STASH}

# export database
export PATH=/c/xampp/mysql/bin:$PATH
mysqldump --user=drupal --password=drupal drupal | bzip2 > ${STASH}/DB.sql.bz

# export configuration
mkdir -p ${STASH}/config
drush config:export --destination=${STASH}/config --yes
tar -cjf ${STASH}/config.tbz -C ${STASH}  config
rm -rf ${STASH}/config

# export files
tar -cjf ${STASH}/files.tbz --exclude ${DEFAULT}/files/feeds/log -C ${DEFAULT} files

# stash settings.php
cp ${DEFAULT}/settings.php ${STASH}/settings.php

