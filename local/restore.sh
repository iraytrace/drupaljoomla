#!/bin/bash

if [ $# -ne 1 -o ! -d $1 ] ; then
	echo usage $0 Timestamp_directory
	exit -1
fi


TS=$1
#!/bin/bash

# Replace with your database credentials
DB_USER="root"
DB_PASS="example"
DB_NAME="drupal"

DRUPAL=/c/xampp/htdocs/jcehdms
DEFAULT=${DRUPAL}/web/sites/default
STASH=$1


# Clear the database
echo restore database
mysql -u $DB_USER -p$DB_PASSWORD -e "DROP database IF EXISTS $DB_NAME;"
mysql -u $DB_USER -p$DB_PASSWORD -e "CREATE DATABASE $DB_NAME;"

bzip2 -d < ${STASH}/DB.sql.bz | mysql -u $DB_USER -p$DB_PASSWORD $DB_NAME
# restore settings.php
echo settings.php
cp ${STASH}/settings.php ${DEFAULT}/settings.php

# restore the config
tar xaf ${STASH}/config.tbz -C ${STASH}
drush config:import --source=${STASH}/config

# restore files
echo files
tar -xaf ${STASH}/files.tbz -C ${DEFAULT}

