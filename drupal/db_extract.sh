#!/bin/bash

if [ $# -ne 1 ] ; then
	echo "Usage $0 dbname"
	exit -1
fi

DB_NAME=$1

# MySQL credentials
DB_USER="root"
DB_PASSWORD="example"
DB_HOST=$(./db_ip.sh)

TABLES=$(mysql -h $DB_HOST -u $DB_USER -p$DB_PASSWORD -e "show tables;" $DB_NAME | tail -n +2)

# Directory to store table dumps
OUTPUT_DIR="./tables"
if [ -d $OUTPUT_DIR ] ; then
	rm -rf $OUTPUT_DIR/*
else
	mkdir -p $OUTPUT_DIR
fi

for TABLE in $TABLES ; do
	echo "SELECT * from $TABLE" | mysql -h $DB_HOST -B -u$DB_USER -p$DB_PASSWORD $DB_NAME > ${OUTPUT_DIR}/${TABLE}.csv
done
