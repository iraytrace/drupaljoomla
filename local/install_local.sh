#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

if [ $# -lt 1 ] ; then
	echo "usage $0 sitename"
	exit -1
fi
SITE=$1

DB_USER=root
DB_PASS=example

export PATH=$PATH:${DRUPAL}/vendor/bin:/c/xampp/mysql/bin
echo "DROP DATABASE IF EXISTS $SITE; CREATE DATABASE $SITE;" | mysql -u $DB_USER -p$DB_PASS

cd /c/xampp/htdocs
composer create-project 'drupal/recommended-project:10.3.5' ${SITE}
cd ${SITE}

cat > .gitignore << EOF
/vendor/
web/core
web/modules/contrib/
web/themes/contrib/
web/sites/*/services*.yml

web/sites/*/files
web/sites/*/private
web/sites/simpletest
EOF

git init .
git add .
git commit -m 'Initial'
mkdir -p config/sync

. ${SCRIPT_DIR}/../drupal/data/drupal_modules.sh
