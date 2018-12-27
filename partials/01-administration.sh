#!/usr/bin/env bash

(
  set -e
  set -u

  sudo yum install -y pam_ssh_agent_auth
)
