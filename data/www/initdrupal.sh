#!/bin/bash
echo 'Borramos la carpeta'
rm -fr  drupal
git clone --branch 8.3.x https://git.drupal.org/project/drupal.git
echo 'Done'
