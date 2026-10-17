#!/bin/bash
# Exercise 5 - needs a Linux host with AppArmor enabled (Ubuntu/Debian) + Docker
set -x
sudo apt-get update && sudo apt-get install -y apparmor-utils
sudo cp my-apparmor-profile /etc/apparmor.d/my-apparmor-profile
sudo apparmor_parser -r /etc/apparmor.d/my-apparmor-profile
sudo aa-status | grep my-apparmor-profile
docker build -t flask-apparmor .
pip install docker
python3 apply_apparmor.py
python3 test_restricted_actions.py
