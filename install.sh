#!/bin/bash
pip3 install -r requirements.txt --user

echo 'Create a symlink in /usr/bin/goDuck'
sudo ln -s ./goDuck.py /usr/bin/goDuck
