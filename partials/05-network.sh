#!/usr/bin/env bash

echo 'plexbox.localdomain' | sudo tee /etc/hostname >/dev/null
sudo hostname -F /etc/hostname
