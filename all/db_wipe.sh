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
	DB_NAME="drupal"
fi

# Define the database credentials
DB_USER="root"
DB_PASSWORD="example"

# find the name of the mariadb container
CONTAINER_NAME=$(docker ps | grep mariadb | awk '{print $NF}')

# Get the IP address of the MariaDB container
CONTAINER_IP=$(./db_ip.sh)

# Clear the database
mysql -h$CONTAINER_IP -u$DB_USER -p$DB_PASSWORD -e "DROP database IF EXISTS $DB_NAME;"
mysql -h$CONTAINER_IP -u$DB_USER -p$DB_PASSWORD -e "CREATE DATABASE $DB_NAME;"
