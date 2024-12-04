#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

echo -------------------------------- DRUSH --------------------------------------
composer require drush/drush

php /data/wait_for_db.php

echo -------------------------------- SITE INSTALL --------------------------------------
# set up from scratch
drush site-install standard \
	--db-url=mysql://drupal:drupal@db/drupal \
	--account-name=boss \
	--account-pass=boss_password \
	--site-name=JCEHDMS \
	--yes

# point config dir outside container
echo -------------------------------- CONFIG DIR --------------------------------------
mkdir -p /data/config/sync
sed -i.bak -E '${s/^(.*=\s*)(.*);/\1"\/data\/config\/sync";/}' web/sites/default/settings.php
rm -R web/sites/default/files/config_*


echo -------------------------------- MODULES --------------------------------------
. ${SCRIPT_DIR}/drupal_modules.sh

# This makes sure the container can write to the files directory
# when drush does the site-install, it is done as root
chown -R www-data:www-data web/sites/default/*

