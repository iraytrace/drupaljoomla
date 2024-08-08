#!/bin/bash
set -e

# Start Apache in the background
apache2-foreground &

# Wait for Joomla to be ready
until curl -s http://localhost/administrator/index.php > /dev/null; do
    echo "Waiting for Joomla to be ready..."
    sleep 5
done

# Install the extension
php /var/www/html/cli/joomla.php extension:install /var/www/html/tmp

# Keep the container running
tail -f /dev/null

