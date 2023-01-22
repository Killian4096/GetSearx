#!/bin/bash
COMMAND = '/usr/local/searx/searx-pyenv/bin/python /usr/local/searx/searx-src/searx/webapp.py'
JOB = reboot sleep 5 && sh -c '$COMMAND'
sudo -H -u searx -i sh -c "crontab -l | { cat; $JOB; } | crontab -"
