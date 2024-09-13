#!/bin/bash

composer require 'drupal/admin_toolbar:^3.5'
# for drupal 10 / 11
# composer require 'drupal/view_custom_table:^2.0'
# for drupal 9.3+ / 10
composer require 'drupal/view_custom_table:2.0.5'
composer require 'drupal/layout_bg:^1.4'

composer require drupal/core-recommended:10.3.4 drupal/core-composer-scaffold:10.3.4 drupal/core-project-message:10.3.4 --update-with-all-dependencies
