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

  echo " - disabling ssh login via password"
  #shellcheck disable=SC2024
  sudo tee /etc/ssh/sshd_config >/dev/null <"${_BASE_CONFIG_DIR}/files/sshd_config"

  echo " - setting plexadmin groups"

  sudo usermod -aG users plexadmin
  sudo usermod -aG adm plexadmin
)
