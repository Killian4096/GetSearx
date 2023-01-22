#!/bin/bash

sudo -H -u searx -i crontab -l | { cat; echo "@reboot sleep 1 | /usr/local/searx/searx-pyenv/bin/python /usr/local/searx/searx-src/searx/webapp.py"; } | crontab -

