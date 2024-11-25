#!/bin/bash
composer require drush/drush

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

# save initial config
drush config:export --yes
cp web/sites/default/settings.php /data/config/
