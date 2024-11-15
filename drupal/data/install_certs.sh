#!/bin/bash

shopt -s nullglob

files=(/data/*.crt)

# Check if the array has any elements
if [[ ${#files[@]} -gt 0 ]]; then
    cp /data/*.crt /usr/local/share/ca-certificates/
    /usr/sbin/update-ca-certificates
fi

shopt -u nullglob
