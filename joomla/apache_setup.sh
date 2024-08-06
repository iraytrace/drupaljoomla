#!/bin/bash
#

sed -i '1i ServerName vm1.lan' /etc/apache2/apache2.conf
. /entrypoint.sh "apache2-foreground"
