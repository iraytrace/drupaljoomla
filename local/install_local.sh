#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
if [ $# -ge 1 ] ; then
SITE=$1
else
SITE=jcehdms
fi
echo ${SITE}

cd /c/xampp/htdocs
composer create-project 'drupal/recommended-project:10.3.5' ${SITE}
cd ${SITE}
. ${SCRIPT_DIR}/../drupal/data/drupal_modules.sh
