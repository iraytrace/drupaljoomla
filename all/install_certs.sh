#!/bin/bash

DRUPALCONTAINER=`docker ps | awk '/drupal-1/ {print $1}'`

# set up modules
crt_files=$(find . -type f -name "*.crt")

if [ ! -z "$crt_files" ] ; then
	for f in $crt_files ; do
		docker cp $f ${DRUPALCONTAINER}:/usr/local/share/ca-certificates/
	done
	docker exec -it ${DRUPALCONTAINER} /usr/sbin/update-ca-certificates
fi
