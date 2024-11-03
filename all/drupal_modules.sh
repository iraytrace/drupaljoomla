#!/bin/bash

composer require 'drupal/admin_toolbar:^3.5'
composer require 'drupal/feeds:^3.0@RC'
composer require 'drupal/menu_items_visibility:^1.1'
composer require 'drupal/workflow:^1.8'
composer require 'drupal/workflows_field:^2.1'
#composer require 'drupal/rules:^4.0'
#composer require 'drupal/migrate_tools:^6.0'
#composer require 'drupal/color:^1.0'
#composer require 'drupal/dxpr_theme_helper:^1.0'
#composer require 'drupal/dxpr_theme:^6.0@RC'
composer require 'drupal/tara:^11.0'
composer require 'drupal/auto_entitylabel:^3.3'
#composer require 'drupal/person:^1.0'
composer require --dev drush/drush
composer require 'drupal/view_custom_table:^2.0'

# for drupal 10 / 11
# composer require 'drupal/view_custom_table:^2.0'
# for drupal 9.3+ / 10
#composer require 'drupal/view_custom_table:2.0.5'
#composer require 'drupal/layout_bg:^1.4'

# composer require drupal/core-recommended:10.3.5 drupal/core-composer-scaffold:10.3.5 drupal/core-project-message:10.3.5 --update-with-all-dependencies
