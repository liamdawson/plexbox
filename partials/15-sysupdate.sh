#!/usr/bin/env bash

(
  set -e
  set -u

  echo ' - installing yum-cron...'

  sudo yum install -y yum-cron

  sudo yum update
  sudo yum upgrade -y
)

