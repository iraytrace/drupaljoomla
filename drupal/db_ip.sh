#!/bin/bash

# find the name of the mariadb container
CONTAINER_NAME=$(docker ps | grep mariadb | awk '{print $NF}')

# Get the IP address of the MariaDB container
CONTAINER_IP=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' "$CONTAINER_NAME")

if [ -z "$CONTAINER_IP" ]; then
  echo "Error: Could not retrieve IP address for container '$CONTAINER_NAME'."
  exit 1
fi

echo "$CONTAINER_IP"
