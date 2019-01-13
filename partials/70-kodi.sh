#!/usr/bin/env bash

(
  set -e
  set -u

  if ! id 'kodi' >/dev/null 2>&1
  then
    sudo useradd kodi -D -p '$2a$07$AJ54EVMPMjzl7Dj9dGm0XuArAPaG3D/s6qZHjVmc2pdvxPHba9oty'
    sudo usermod kodi -aG audio
    sudo usermod kodi -aG video
  fi

  # yum install -y kodi
)

