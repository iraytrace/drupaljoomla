#!/bin/bash

echo "SHOW TABLES LIKE '%cache%'" | mysql -u root -pexample drupal | \
	tail -n +2 | \
	xargs -I% echo "TRUNCATE TABLE %;" | \
	mysql -u root -pexample drupal
