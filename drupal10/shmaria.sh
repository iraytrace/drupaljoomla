#!/bin/bash

DBCONTAINER=`docker ps | awk '/mariadb/ {print $1}'`
docker exec -it ${DBCONTAINER} bash

