#!/bin/bash

# sudo composer require 'drush/drush'

composer require 'drupal/admin_toolbar:^3.5'
composer require 'drupal/auto_entitylabel:^3.3'
composer require 'drupal/feeds:^3.0@RC'
composer require 'drupal/menu_items_visibility:^1.1'
composer require 'drupal/view_custom_table:^2.0'
composer require 'drupal/single_content_sync:^1.4'
composer require 'drupal/taxonomy_import:^2.0'
#composer require 'drupal/eca' 'drupal/bpmn_io'
#composer require 'drupal/eca_tamper'
#composer require 'drupal/eca_content_access:^1.0'
#composer require 'drupal/workflow:^1.8'
#composer require 'drupal/workflows_field:^2.1'

# composer require drupal/core-recommended:10.3.5 drupal/core-composer-scaffold:10.3.5 drupal/core-project-message:10.3.5 --update-with-all-dependencies

echo -------------------------------- CORE MODULES --------------------------------------------
drush pm:enable media media_library datetime_range telephone \
	admin_toolbar admin_toolbar_tools admin_toolbar_search \
	auto_entitylabel feeds menu_items_visibility view_custom_table single_content_sync taxonomy_import
 if [ $? -ne 0 ]; then
	echo error enabling modules
fi
