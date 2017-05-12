#!/bin/bash
echo '============== INIT Drupal Download =============='
echo 'Borramos la carpeta'
rm -fr  drupal
echo "Descargamos Drupal"
drush dl drupal
mv drupal-* drupal
chown -R me:me drupal
echo 'Done'
echo '============== END Drupal Download =============='
echo '============== INIT Drupal Installation =============='
cd drupal
#sudo rm -fr vendor
#composer install
chmod 777 sites/default
cd sites/default
rm -fr settings.php  services.yml
# for developers only (sets up some dev mode settings, do this before install!)
cp ../example.settings.local.php ./settings.local.php
# for everyone
cp default.settings.php settings.php
cp default.services.yml services.yml
chmod 0666 settings.php services.yml
rm -fr files
mkdir files
#chown keopx:www-data files # NB this is server/user specific!
chmod -R 777 files
echo "\$settings['hash_salt'] = 'Um_Y9hqOMH0X3fPkBCxRMhIJLH7P1YiIrNXAx91vtsggbFz2-cr_EQ6Z6tVRujeAm0eUMDEhBA';" >> settings.php
# drush8="/home/keopx/.drush/vendor/bin/drush"
drush si standard --db-url=mysql://drupaluser:drupalpass@mysql/drupal --site-name="drupal test" --account-name=root --account-pass=root --account-mail=ruben.egiguren@biko2.com -y
drush en admin_toolbar admin_toolbar_tools -y
# Add local env setup
sed -i 's/# if (file_exists/if (file_exists/' settings.php
sed -i 's/#   include $app_root/  include $app_root/' settings.php
sed -i 's/# }/}/' settings.php
sed -i 's/# $settings/$settings/' settings.local.php
drush cr
drush en admin_toolbar admin_toolbar_tools -y
drush cr
echo 'Done'
echo '============== DONE Drupal Installation =============='
