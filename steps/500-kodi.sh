#!/usr/bin/env bash

(
  set -eu

  sudo apt install -y kodi kodi-bin

  id 'kodi' >/dev/null 2>&1 || echo '' | sudo useradd -m kodi
  sudo usermod -aG audio,video kodi

  sudo systemctl disable --now kodi || true
)
