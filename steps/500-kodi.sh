#!/usr/bin/env bash

(
  set -eu

  sudo apt install -y kodi kodi-bin

  sudo usermod -aG audio,video kodi

  sudo tee "/etc/systemd/system/kodi.service" >/dev/null <"${_BASE_CONFIG_DIR}/files/kodi.service"

  sudo systemctl reload-daemon
  sudo systemctl enable --now kodi
)

