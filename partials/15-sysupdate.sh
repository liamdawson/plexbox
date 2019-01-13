#!/usr/bin/env bash

(
  set -e
  set -u

  echo ' - installing yum-cron...'

  # TODO: enable?
  sudo yum install -y yum-cron

  sudo yum update -y
  sudo yum upgrade -y
)

