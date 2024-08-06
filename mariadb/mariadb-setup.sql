CREATE DATABASE IF NOT EXISTS joomla;
CREATE DATABASE IF NOT EXISTS drupal;
CREATE USER 'joomla'@'%' IDENTIFIED BY 'joomla_password';
CREATE USER 'drupal'@'%' IDENTIFIED BY 'drupal_password';
GRANT ALL PRIVILEGES ON joomla.* TO 'joomla'@'%';
GRANT ALL PRIVILEGES ON drupal.* TO 'drupal'@'%';
FLUSH PRIVILEGES;
