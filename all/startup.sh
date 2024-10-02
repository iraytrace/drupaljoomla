#!/bin/bash

docker compose up -d

DRUPALCONTAINER=`docker ps | awk '/drupal-1/ {print $1}'`
