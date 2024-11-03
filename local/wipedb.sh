#!/bin/bash

# Replace with your database credentials
DB_USER="drupal"
DB_PASS="drupal"
DB_NAME="drupal"


export PATH=/c/xampp/mysql/bin/:$PATH
echo database
# Execute the command to drop all tables
mysql --user="$DB_USER" --password="$DB_PASS" -N -e "SET FOREIGN_KEY_CHECKS = 0;
	SELECT CONCAT('DROP TABLE IF EXISTS ', table_name, ';')
	FROM information_schema.tables WHERE table_schema = '$DB_NAME'; " | \
		mysql --user="$DB_USER" --password="$DB_PASS" "$DB_NAME"
