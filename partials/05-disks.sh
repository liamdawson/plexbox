#!/usr/bin/env bash

(
  set -e
  set -u

  if [[ ! -d /media/data ]]
  then
    sudo mkdir /media/data
    sudo chown nobody:users /media/data
  fi

  if ! sudo grep -qe 'PBX_MEDIA' /etc/fstab >/dev/null
  then
    echo "/dev/disk/by-partlabel/PBX_MEDIA /media/data    btrfs   defaults       0 0" | sudo tee -a /etc/fstab >/dev/null
  fi
)
