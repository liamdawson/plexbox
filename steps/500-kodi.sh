#!/usr/bin/env bash

(
  set -eu

  sudo apt install -y kodi kodi-bin

  id 'kodi' >/dev/null 2>&1 || echo '' | sudo useradd kodi
  sudo usermod -aG audio,video kodi

  sudo tee "/etc/systemd/system/kodi.service" >/dev/null <"${_BASE_CONFIG_DIR}/files/kodi.service"

  sudo systemctl daemon-reload
  sudo systemctl enable --now kodi
)

