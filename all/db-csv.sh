#!/bin/bash

if [ $# -ne 1 ] ; then

	echo "Usage $0 dbname"
	exit -1
fi
DBCONTAINER=`docker ps | awk '/mariadb/ {print $1}'`
docker cp $1 $DBCONTAINER:/db.sql
docker cp db_ingest_and_dump_csv.sh $DBCONTAINER:/db_ingest_and_dump_csv.sh
docker exec -it $DBCONTAINER /db_ingest_and_dump_csv.sh
docker cp $DBCONTAINER:/csv.tgz ./csv.tgz
