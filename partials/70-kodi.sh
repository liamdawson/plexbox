#!/usr/bin/env bash

(
  set -e
  set -u

  sudo yum groupinstall -y x11

  if ! id 'kodi' >/dev/null 2>&1
  then
    echo '' | sudo useradd -p '$2a$07$AJ54EVMPMjzl7Dj9dGm0XuArAPaG3D/s6qZHjVmc2pdvxPHba9oty' kodi
    sudo usermod kodi -aG audio
    sudo usermod kodi -aG video
  fi

  sudo yum install -y dbus-x11 upower kodi

  #shellcheck disable=SC2024
  sudo tee /etc/systemd/system/kodi.service >/dev/null <"${_BASE_CONFIG_DIR}/files/kodi.service"
  #shellcheck disable=SC2024
  sudo tee /etc/polkit-1/localauthority/50-local.d/kodi_shutdown.pkla >/dev/null <"${_BASE_CONFIG_DIR}/files/kodi_shutdown.pkla"
  #shellcheck disable=SC2024
  sudo tee /etc/X11/Xwrapper.config >/dev/null <"${_BASE_CONFIG_DIR}/files/Xwrapper.config"
  sudo chmod 644 /etc/X11/Xwrapper.config

  sudo systemctl daemon-reload
  sudo systemctl enable --now kodi
)
