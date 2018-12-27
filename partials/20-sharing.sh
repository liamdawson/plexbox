#!/usr/bin/env bash

(
  set -e
  set -u

  sudo yum install -y samba samba-client samba-common

  echo ' - setting SELinux permissions for shares'
  sudo chcon -t samba_share_t /media/data/
  sudo restorecon -R /media/data

  echo ' - setting samba configuration'
  #shellcheck disable=SC2024
  sudo tee /etc/samba/smb.conf >/dev/null < "${_BASE_CONFIG_DIR}/files/smb.conf"

  sudo systemctl restart smb
)
