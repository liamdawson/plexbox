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

  # yum install -y kodi
)

