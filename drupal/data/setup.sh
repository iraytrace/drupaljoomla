#!/bin/bash
composer require drush/drush

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
. ${SCRIPT_DIR}/drupal_modules.sh

# set up from scratch
drush site-install standard \
	--db-url=mysql://drupal:drupal@db/drupal \
	--account-name=boss \
	--account-pass=boss_password \
	--site-name=JCEHDMS \
	--yes

# point config dir outside container
mkdir -p /data/config/sync
sed -i.bak -E '${s/^(.*=\s*)(.*);/\1"\/data\/config\/sync";/}' web/sites/default/settings.php
rm -R web/sites/default/files/config_*

chown -R www-data:www-data web/sites/default/*

