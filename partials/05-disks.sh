#!/usr/bin/env bash

(
  set -e
  set -u

  if ! sudo grep -qe 'PBX_MEDIA' /etc/fstab >/dev/null
  then
    echo "/dev/disk/by-partlabel/PBX_MEDIA /media/data ext4 defaults 0 0" | sudo tee -a /etc/fstab >/dev/null
  fi
)
