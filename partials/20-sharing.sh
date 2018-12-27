#!/usr/bin/env bash

(
  set -e
  set -u

  sudo yum install -y samba samba-client samba-common

  sudo chcon -t samba_share_t /media/data/
  sudo restorecon -R /media/data
)
