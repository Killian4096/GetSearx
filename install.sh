#!/bin/bash
set -e

echo "start"

apt-get install -y python3-dev python3-babel python3-venv uwsgi uwsgi-plugin-python3 git build-essential libxslt-dev zlib1g-dev libffi-dev libssl-dev shellcheck

useradd --shell /bin/bash --system --home-dir "/usr/local/searx" searx
mkdir "/usr/local/searx"
chown -R "searx:searx" "/usr/local/searx"

echo "start1"

sudo -H -u searx -i
python3 -m venv "/usr/local/searx/searx-pyenv"
echo ". /usr/local/searx/searx-pyenv/bin/activate" >>  "/usr/local/searx/.profile"
exit

echo "start2"


sudo -H -u searx -i
source ~/.profile
pip install -U pip
pip install -U setuptools
pip install -U wheel
pip install -U pyyaml

echo "start3"

cd "/usr/local/searx/searx-src"
pip install -e .
exit

echo "start4"

mkdir -p "/etc/searx"
cp "/usr/local/searx/searx-src/utils/templates/etc/searx/use_default_settings.yml" "/etc/searx/settings.yml"
sed -i -e "s/ultrasecretkey/$(openssl rand -hex 16)/g" "/etc/searx/settings.yml"
sed -i -e "s/{instance_name}/searx@$(uname -n)/g" "/etc/searx/settings.yml"

echo "start5"

cd /usr/local/searx/searx-src
export SEARX_SETTINGS_PATH="/etc/searx/settings.yml"
exit
