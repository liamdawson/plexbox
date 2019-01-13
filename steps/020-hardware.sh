#!/usr/bin/env bash

(
  set -eu

  grep -q 'PBX_MEDIA' /etc/fstab || echo 'PARTLABEL=PBX_MEDIA /media/data btrfs defaults 0 0' | sudo tee -a /etc/fstab >/dev/null
  [[ -d /media/data ]] || sudo mkdir -p /media/data
)
