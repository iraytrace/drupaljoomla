#!/bin/bash

if [ $# -ne 2 ] ; then
	echo "Usage $0 input.sql"
	exit -1
fi

# MySQL credentials
DB_USER="root"
DB_PASSWORD="example"
DB_NAME="ingest"

mysql -u$DB_USER -p$DB_PASSWORD -e "create database $DB_NAME;"
mysql -u$DB_USER -p$DB_PASSWORD $DB_NAME < $1
TABLES=$(awk '/DROP TABLE/ {print $5}' < $1)

# Directory to store table dumps
OUTPUT_DIR="./tables"
if [ ! -d $OUTPUT_DIR ] ; then
	mkdir -p $OUTPUT_DIR
fi

for TABLE in $TABLES ; do
	echo "SELECT * from $TABLE" | mysql -B -u$DB_USER -p$DB_PASSWORD $DB_NAME > ${TABLE}.tsv
done
mysql -u$DB_USER -p$DB_PASSWORD -e "drop database $DB_NAME;"
tar cvf tables.tbz $OUTPUT_DIR
