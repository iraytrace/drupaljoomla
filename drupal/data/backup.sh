#!/bin/bash

if [ $# -ne 1 ] ; then
	echo "Usage $0 userid"
	exit -1
fi

USERID=$1

drush cr
drush config:export --yes

tar cjf /data/config/files.tbz web/sites/default/files web/sites/default/settings.php composer.*
chown $USERID:$USERID /data/config/files.tbz
chgrp $USERID /data/config/sync/*
chmod g+w /data/config/sync/*

