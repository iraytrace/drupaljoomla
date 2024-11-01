#!/bin/bash

cd /c/xampp/htdocs
composer create-project 'drupal/recommended-project:^10' jcehdms
cd jcehdms
. /c/users/butler/Documents/src/drupaljoomla/all/drupal_modules.sh
cp -r /c/users/butler/Documents/src/
tar -xaf ~/Documents/src/Drupal/Tarapro-Drupal-Theme-ul/tarapro.tar -C /c/xampp/htdocs/jcehdms/web/themes
