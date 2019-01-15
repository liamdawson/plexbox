#!/usr/bin/env bash

(
  set -eu

  # I think this has been causing DLNA/Sonos issues?
  # sudo apt install -y kodi kodi-bin

  id 'kodi' >/dev/null 2>&1 || echo '' | sudo useradd -m kodi
  sudo usermod -aG audio,video kodi
)
