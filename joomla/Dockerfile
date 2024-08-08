# Use the official Joomla image from Docker Hub
FROM joomla:latest

# Set environment variables
ENV     JOOMLA_DB_HOST: mariadb
ENV     JOOMLA_DB_USER: joomla
ENV     JOOMLA_DB_PASSWORD: joomla_password
ENV     JOOMLA_DB_NAME: joomla
ENV     JOOMLA_SITE_NAME: "UXOCOE"
ENV     JOOMLA_ADMIN_USER: Joomla Hero
ENV     JOOMLA_ADMIN_USERNAME: boss
ENV     JOOMLA_ADMIN_PASSWORD: boss_password
ENV     JOOMLA_ADMIN_EMAIL: iraytrace@gmail.com

# Update the package repository and install necessary tools
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Define the URL for the Joomla extension (replace with your extension URL)
ARG EXTENSION_URL="https://joomcode.com/index.php/download/category/4-jc-tables?download=6:jc-tables-free"

# Download and install the Joomla extension
RUN wget -O /tmp/extension.zip "$EXTENSION_URL" && \
    unzip /tmp/extension.zip -d /var/www/html/tmp/ && \
    rm /tmp/extension.zip && \
    chown -R www-data:www-data /var/www/html/tmp

# Copy custom entrypoint script to install the extension
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Set the entrypoint script
ENTRYPOINT ["/entrypoint.sh"]

# Expose HTTP port
EXPOSE 80


services:
  joomla:
    build: .
    container_name: joomla
    depends_on:
      - mariadb
    environment:
      JOOMLA_DB_HOST: mariadb
      JOOMLA_DB_USER: joomla
      JOOMLA_DB_PASSWORD: joomla_password
      JOOMLA_DB_NAME: joomla
      JOOMLA_SITE_NAME: "UXOCOE"
      JOOMLA_ADMIN_USER: Joomla Hero
      JOOMLA_ADMIN_USERNAME: boss
      JOOMLA_ADMIN_PASSWORD: boss_password
      JOOMLA_ADMIN_EMAIL: iraytrace@gmail.com
    networks:
      - internal
      - local_network
    ports:
      - "8082:80" # Expose Joomla on port 8082
    volumes:
      - joomla_data:/var/www/html
      - ./apache_setup.sh:/usr/local/bin/apache_setup.sh
    entrypoint: ["/bin/bash", "/usr/local/bin/apache_setup.sh"]
