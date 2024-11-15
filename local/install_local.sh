#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

cd /c/xampp/htdocs
composer create-project 'drupal/recommended-project:^10' jcehdms
cd jcehdms
. ${SCRIPT_DIR}/drupal_modules.sh
#tar -xaf ~/Documents/src/Drupal/Tarapro-Drupal-Theme-ul/tarapro.tar -C /c/xampp/htdocs/jcehdms/web/themes
