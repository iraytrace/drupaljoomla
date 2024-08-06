#!/bin/bash
set -e

# Function to check if database is available
check_db() {
  until mysql -h mariadb -u drupal -pdrupal_password -e "SHOW DATABASES;" 2>/dev/null; do
    echo "Waiting for mariadb drupal database connection..."
    sleep 2
  done
}

# Wait for the database to be ready
check_db

# Install Drupal and configure site
drush site-install --db-url=mysql://drupal:drupal_password@mariadb/drupal \
                   --site-name="UXOCOE" \
                   --account-name="admin" \
                   --account-pass="admin_password" \
                   --yes

# Set admin email address
drush user:password admin admin_password
drush config:set system.site mail "iraytrace@gmail.com" -y

sed -i '1i ServerName vm1.lan' /etc/apache2/apache2.conf

# Start Apache in the foreground
exec apache2-foreground

