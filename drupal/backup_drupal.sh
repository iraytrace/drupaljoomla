#!/bin/bash

DRUPALCONTAINER=`docker ps | awk '/drupal-1/ {print $1}'`

mkdir -p data/config
	
USERID=$(id -u) 

# save the drupal data and files
docker exec -it ${DRUPALCONTAINER}  sh -c "drush config:export --yes ; cp web/sites/default/settings.php /data/config/settings.php ; chown $USERID:$USERID /data/config/settings.php ; chgrp $USERID /data/config/sync/* ; chmod g+w /data/config/sync/* "

