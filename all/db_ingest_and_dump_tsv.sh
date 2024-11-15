#!/bin/bash

if [ $# -lt 1 ] ; then
	echo "Usage $0 input.sql [db_name]"
	exit -1
else
	FILE=$1
fi
if [ $# -ge 2 ] ; then
	DB_NAME=$2
else
	DB_NAME="extern"
fi

# Define the database credentials
DB_USER="root"
DB_PASSWORD="example"

# Get the IP address of the MariaDB container
CONTAINER_IP=$(./db_ip.sh)

if [ -z "$CONTAINER_IP" ]; then
  echo "Error: Could not retrieve IP address for container '$CONTAINER_NAME'."
  exit 1
fi

echo "MariaDB container IP address: $CONTAINER_IP"

# clear the database
./db_wipe.sh "$DB_NAME"


# load sql file into database
mysql -h$CONTAINER_IP -u$DB_USER -p$DB_PASSWORD $DB_NAME < $1


# Get the list of tables in the specified database
TABLES=$(mysql -h "$CONTAINER_IP" -u "$DB_USER" -p"$DB_PASSWORD" -D "$DB_NAME" -e "SHOW TABLES;" 2>/dev/null)

if [ $? -ne 0 ]; then
  echo "Error: Could not connect to the database or fetch the tables. Please check your credentials."
  exit 1
fi

# Print the list of tables
echo "Tables in the database '$DB_NAME':"
echo "$TABLES"


# Make directory to store table dumps
OUTPUT_DIR="./tables"
if [ -d $OUTPUT_DIR ] ; then
	rm -rf $OUTPUT_DIR/*
else
	mkdir -p $OUTPUT_DIR
fi

for TABLE in $TABLES ; do
	echo "SELECT * from $TABLE" | mysql -B -u$DB_USER -p$DB_PASSWORD $DB_NAME > ${OUTPUT_DIR}/${TABLE}.tsv
done
mysql -u$DB_USER -p$DB_PASSWORD -e "drop database $DB_NAME;"
tar cvf tables.tbz $OUTPUT_DIR
rm -rf $OUTPUT_DIR
