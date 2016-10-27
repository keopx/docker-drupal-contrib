#!/bin/bash
cd drupal
composer install
sudo chmod 777 sites/default
cd sites/default
sudo rm -fr settings.php  services.yml
# for developers only (sets up some dev mode settings, do this before install!)
cp ../example.settings.local.php ./settings.local.php
# for everyone
cp default.settings.php settings.php
cp default.services.yml services.yml
chmod 0666 settings.php services.yml
sudo rm -fr files
mkdir files
sudo chown keopx:www-data files # NB this is server/user specific!
chmod 0775 files
# drush8="/home/keopx/.drush/vendor/bin/drush"
drush si standard --db-url=mysql://drupaluser:drupalpass@mysql/drupal --site-name="drupal test" --account-name=root --account-pass=root --account-mail=ruben.egiguren@biko2.com -y
drush en admin_toolbar admin_toolbar_tools -y
# Add local env setup
sudo sed -i 's/# if (file_exists/if (file_exists/' settings.php
sudo sed -i 's/#   include __DIR__/  include __DIR__/' settings.php
sudo sed -i 's/# }/}/' settings.php
sudo sed -i 's/# $settings/$settings/' settings.local.php
drush cr
drush en admin_toolbar admin_toolbar_tools -y
drush cr
echo 'Done'