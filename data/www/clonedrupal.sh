#!/bin/bash
echo 'Borramos la carpeta'
rm -fr  drupal
echo "Descargamos Drupal"
drush dl drupal
mv drupal-* drupal
chown -R me:me drupal
echo 'Done'
