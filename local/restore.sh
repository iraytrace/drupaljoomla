#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

if [ $# -ne 2 -o ! -d $1 ] ; then
	echo usage $0 Timestamp_directory site
	exit -1
fi

STASH=$(realpath $1)
SITE=$2

# Replace with your database credentials
DB_USER="root"
DB_PASS="example"

DRUPAL=/c/xampp/htdocs/${SITE}
DEFAULT=${DRUPAL}/web/sites/default

export PATH=$PATH:${DRUPAL}/vendor/bin:/c/xampp/mysql/bin

# Clear the database
echo wipe database
echo "DROP database IF EXISTS $SITE;" | mysql -u $DB_USER -p$DB_PASS
echo "CREATE DATABASE $SITE;" | mysql -u $DB_USER -p$DB_PASS

echo restore database
gunzip < ${STASH}/DB.sql.gz | mysql -u $DB_USER -p$DB_PASS $SITE

# restore settings.php
echo settings.php
cp ${STASH}/settings.php ${DEFAULT}/settings.php

# restore the config
echo tar xaf ${STASH}/config.tbz -C ${STASH}
tar xaf ${STASH}/config.tbz -C ${STASH}
echo cd ${DRUPAL}
cd ${DRUPAL}
echo drush config:import --source=${STASH}/config
drush config:import --source=${STASH}/config
cd -

# restore files
echo files
tar -xaf ${STASH}/files.tbz -C ${DEFAULT}



