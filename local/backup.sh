#!/bin/bash

export PATH=/c/xampp/mysql/bin:$PATH
TS=$(date '+%Y_%m_%d_%H%M-%S')
mysqldump --user=drupal --password=drupal drupal > site_${TS}.sql
tar  -cjf site_${TS}.tbz -C /c/xampp/htdocs jcehdms

