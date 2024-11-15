#!/bin/bash


cp /data/*.crt /usr/local/share/ca-certificates/
/usr/sbin/update-ca-certificates
