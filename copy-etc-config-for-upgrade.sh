# backup existing custom configs
cp -p /etc/apache2/apache2.conf ~/etc/wingsdev/apache2/
cp -p /etc/apache2/envvars ~/etc/wingsdev/apache2/
cp -p /etc/apache2/sites-available/000-default.conf etc/~/etc/wingsdev/apache2/sites-available/

cp -p /etc/php5/apache2/php.ini wingsdev/php5/apache2/
cp -p /etc/php5/mods-available/xdebug.ini wingsdev/php5/mods-available/
cp -p /etc/php5/cli/php.ini  wingsdev/php5/cli/

cp -p /etc/updatedb.conf wingsdev/

# Merge them
meld ~/etc/wingsdev/apache2/apache2.conf /etc/apache2/apache2.conf &
meld ~/etc/wingsdev/apache2/envvars /etc/apache2/envvars &
meld ~/etc/wingsdev/apache2/sites-available/000-default.conf /etc/apache2/sites-available/000-default.conf &

meld ~/etc/wingsdev/php5/apache2/php.ini  /etc/php5/apache2/php.ini &
meld ~/etc/wingsdev/php5/mods-available/xdebug.ini  /etc/php5/mods-available/xdebug.ini &
meld ~/etc/wingsdev/php5/cli/php.ini /etc/php5/cli/php.ini &

meld ~/etc/wingsdev/updatedb.conf /etc/updatedb.conf &


# Backup default configs
mkdir -p ~/etc/ubuntu-lts-14-default/apache2 && cp -p /etc/apache2/apache2.conf ~/etc/ubuntu-lts-14-default/apache2/
cp -p /etc/apache2/envvars ~/etc/ubuntu-lts-14-default/apache2/
mkdir -p ~/etc/ubuntu-lts-14-default/php5/apache2/
cp -p /etc/php5/apache2/php.ini ~/etc/ubuntu-lts-14-default/php5/apache2/
mkdir -p ~/etc/ubuntu-lts-14-default/php5/mods-available/
cp -p /etc/php5/mods-available/xdebug.ini ~/etc/ubuntu-lts-14-default/php5/mods-available/
mkdir ~/etc/ubuntu-lts-14-default/php5/cli/
cp -p /etc/php5/cli/php.ini  ~/etc/ubuntu-lts-14-default/php5/cli/
cp -p /etc/updatedb.conf ~/etc/ubuntu-lts-14-default/
mkdir ~/etc/ubuntu-lts-14-default/apache2/sites-available/ && cp -p /etc/apache2/sites-available/000-default.conf ~/etc/ubuntu-lts-14-default/apache2/sites-available/

# Copy back
sudo cp ~/etc/wingsdev/apache2/apache2.conf /etc/apache2/
sudo cp ~/etc/wingsdev/apache2/envvars /etc/apache2/
sudo cp ~/etc/wingsdev/apache2/sites-available/000-default.conf /etc/apache2/sites-available/
sudo cp ~/etc/wingsdev/php5/apache2/php.ini  /etc/php5/apache2/php.ini
sudo cp ~/etc/wingsdev/php5/mods-available/xdebug.ini  /etc/php5/mods-available/xdebug.ini
sudo cp ~/etc/wingsdev/php5/cli/php.ini /etc/php5/cli/php.ini
sudo cp ~/etc/wingsdev/updatedb.conf /etc/updatedb.conf
