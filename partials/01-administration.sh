#!/usr/bin/env bash

(
  set -e
  set -u

  echo " - enabling sudo via SSH keys"
  sudo yum install -y pam_ssh_agent_auth

  #shellcheck disable=SC2024
  sudo tee /etc/pam.d/sudo >/dev/null <"${_BASE_CONFIG_DIR}/files/sudo-pam"

  #shellcheck disable=SC2024
  sudo tee /etc/sudoers.d/01-ssh-sock-env >/dev/null <"${_BASE_CONFIG_DIR}/files/sudoers-ssh-sock"

  echo " - setting plexadmin groups"

  sudo useradd -aG users plexadmin
  sudo useradd -aG adm plexadmin
)
