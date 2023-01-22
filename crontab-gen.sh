#!/bin/bash
COMMAND=\'/usr/local/searx/searx-pyenv/bin/python /usr/local/searx/searx-src/searx/webapp.py\'
echo $COMMAND
#sudo -H -u searx -i sh -c crontab -l | { cat; echo @reboot sleep 5 && sh -c \'/usr/local/searx/searx-pyenv/bin/python /usr/local/searx/searx-src/searx/webapp.py\'; } | crontab -
