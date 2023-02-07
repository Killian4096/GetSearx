#!/bin/bash
COMMAND="@reboot sleep 2 && sh -c "\'"/usr/local/searx/searx-pyenv/bin/python /usr/local/searx/searx-src/searx/webapp.py"\'
{ crontab -l -u searx; echo $COMMAND; } | crontab -u searx -
