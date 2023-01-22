#!/bin/bash
#!/usr/bin/env bash

apt-get install -y python3-dev python3-babel python3-venv uwsgi uwsgi-plugin-python3 git build-essential libxslt-dev zlib1g-dev libffi-dev libssl-dev shellcheck

useradd --shell /bin/bash --system --home-dir "/usr/local/searx" searx
mkdir "/usr/local/searx"
chown -R "searx:searx" "/usr/local/searx"

sudo -H -u searx -i git clone "https://github.com/searx/searx.git" "/usr/local/searx/searx-src"

sudo -H -u searx -i python3 -m venv "/usr/local/searx/searx-pyenv"
sudo -H -u searx -i echo ". /usr/local/searx/searx-pyenv/bin/activate" >>  "/usr/local/searx/.profile"


sudo -H -u searx -i pip install -U pip
sudo -H -u searx -i pip install -U setuptools
sudo -H -u searx -i pip install -U wheel
sudo -H -u searx -i pip install -U pyyaml


sudo -H -u searx -i sh -c "cd /usr/local/searx/searx-src && pip install -e ."

mkdir -p "/etc/searx"

cp "/usr/local/searx/searx-src/utils/templates/etc/searx/use_default_settings.yml" "/etc/searx/settings.yml"

sed -i -e "s/ultrasecretkey/$(openssl rand -hex 16)/g" "/etc/searx/settings.yml"
sed -i -e "s/{instance_name}/searx@$(uname -n)/g" "/etc/searx/settings.yml"

sudo -H -u searx -i sh -c 'cd /usr/local/searx/searx-src && export SEARX_SETTINGS_PATH="/etc/searx/settings.yml"'

echo "What ip would you like to bind searx to?(default=localhost):"
read BINDIP
if [ -z "$BINDIP" ]
then
    BINDIP="127.0.0.1"
fi
echo Binding to $BINDIP
sed -i -e "s/127.0.0.1/$BINDIP/g" "/etc/searx/settings.yml"

echo "Would you like to install a cronjob for searx (y/N):"
read CRONOP
if [ "$CRONOP" != "${CRONOP#[Yy]}" ] ;then
    echo "Installing Cronjob"
    SCRIPT_DIR=$( realpath -- "$0" )
    SCRIPT_DIR=$( dirname "$SCRIPT_DIR")
    SCRIPT_NAME="crontab-gen.sh"
    SCRIPT_DIR=$SCRIPT_DIR/$SCRIPT_NAME
    sh $SCRIPT_DIR
fi

