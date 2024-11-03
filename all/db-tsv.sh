#!/bin/bash

if [ $# -ne 1 ] ; then

	echo "Usage $0 dbname"
	exit -1
fi
DBCONTAINER=`docker ps | awk '/mariadb/ {print $1}'`
docker cp $1 $DBCONTAINER:/db.sql
docker cp db_ingest_and_dump_tsv.sh $DBCONTAINER:/db_ingest_and_dump_tsv.sh
docker exec -it $DBCONTAINER /db_ingest_and_dump_tsv.sh /db.sql
docker cp $DBCONTAINER:/tables.tbz ./tables.tbz
