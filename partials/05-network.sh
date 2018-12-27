#!/usr/bin/env bash

(
  set -e
  set -u

  echo ' - setting hostname...'

  echo 'plexbox.localdomain' | sudo tee /etc/hostname >/dev/null
  sudo hostname -F /etc/hostname

  echo ' - adding firewall service definitions'
  sudo cp "${_BASE_CONFIG_DIR}/files/plex-firewall-service.xml" /etc/firewalld/services/plex.xml

  function firewallcmd() {
    #shellcheck disable=SC2068
    sudo firewall-cmd -q $@ || {
      _STATUS="$?"
      [[ $? -eq 11 ]] || return $_STATUS
    }
    # 11 means already set
  }

  echo ' - configuring firewall transiently...'
  firewallcmd --reload

  firewallcmd --set-default-zone=home
  firewallcmd --zone=home --add-service=ssh
  firewallcmd --zone=home --add-service=http
  firewallcmd --zone=home --add-service=https
  firewallcmd --zone=home --add-service=dns
  firewallcmd --zone=home --add-service=plex
  firewallcmd --zone=home --add-service=samba

  echo ' - configuring firewall permanently...'
  firewallcmd --runtime-to-permanent
)
