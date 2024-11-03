#!/bin/bash

cd /c/xampp/htdocs
composer create-project 'drupal/recommended-project:^10' jcehdms
cd jcehdms
. /c/users/butler/Documents/src/drupaljoomla/all/drupal_modules.sh
tar -xaf ~/Documents/src/Drupal/Tarapro-Drupal-Theme-ul/tarapro.tar -C /c/xampp/htdocs/jcehdms/web/themes
