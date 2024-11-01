#!/bin/bash

if [ $# -ne 1 ] ; then
	echo usage $0 Timestamp
	exit -1
fi

TS=$1
#!/bin/bash

# Replace with your database credentials
DB_USER="drupal"
DB_PASS="drupal"
DB_NAME="drupal"


export PATH=/c/xampp/mysql/bin/:$PATH
if [ -f site_${TS}.sql -a -f site_${TS}.tbz ] ; then
	echo database
	# Execute the command to drop all tables
	mysql --user="$DB_USER" --password="$DB_PASS" -N -e "SET FOREIGN_KEY_CHECKS = 0;
	SELECT CONCAT('DROP TABLE IF EXISTS ', table_name, ';')
	FROM information_schema.tables WHERE table_schema = '$DB_NAME'; " | mysql --user="$DB_USER" --password="$DB_PASS" "$DB_NAME"
	mysql --user="$DB_USER" --password="$DB_PASS" "$DB_NAME" < site_${TS}.sql

	echo files
	if [ -d /c/xampp/htdocs/jcehdms ] ; then
		echo rm /c/xampp/htdocs/jcehdms
		rm -rf /c/xampp/htdocs/jcehdms
	fi
	echo untar ...
	tar xaf site_${TS}.tbz -C /c/xampp/htdocs
else
	echo missing site_${TS}.sql or site_${TS}.tbz for restore
fi
