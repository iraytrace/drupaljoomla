#!/bin/bash

USER="drupal"
PASSWORD="drupal"
DB="drupal"

# Maximum number of retries
MAX_RETRIES=30
# Delay between retries (in seconds)
DELAY=5

echo "Waiting for MariaDB to be ready..."

READY=0

for ((i=1; i<=MAX_RETRIES; i++)); do
    mysql -u"$USER" -p"$PASSWORD" -e "SELECT 1;" $DB &> /dev/null
    if [ $? -eq 0 ]; then
	ready=1
        break
    else
        echo "Attempt $i of $MAX_RETRIES failed. Retrying in $DELAY seconds..."
        sleep $DELAY
    fi
done

if [ $READY ] ; then
	echo mariadb ready
	gunzip < /data/config/DB.sql.gz | mysql --user=$USER --password=$PASSWORD $DB
else
	echo "MariaDB is not ready after $MAX_RETRIES attempts. Exiting."
fi
