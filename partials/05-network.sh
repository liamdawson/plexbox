#!/usr/bin/env bash

echo ' - setting hostname...'

echo 'plexbox.localdomain' | sudo tee /etc/hostname >/dev/null
sudo hostname -F /etc/hostname

echo ' - adding firewall service definitions'
sudo cp "${_BASE_CONFIG_DIR}/files/plex-firewall-service.xml" /etc/firewalld/services/plex.xml


echo ' - configuring firewall transiently...'
sudo firewall-cmd --set-default-zone=home
sudo firewall-cmd --zone=home --add-service=ssh
sudo firewall-cmd --zone=home --add-service=plex


echo ' - configuring firewall permanently...'
sudo firewall-cmd --runtime-to-permanent
