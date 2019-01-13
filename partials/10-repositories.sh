#!/usr/bin/env bash

(
  set -e
  set -u

  echo ' - enabling epel...'

  sudo yum localinstall --nogpgcheck http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

  echo ' - enabling rpmfusion...'

  sudo yum localinstall --nogpgcheck https://download1.rpmfusion.org/free/el/rpmfusion-free-release-7.noarch.rpm https://download1.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-7.noarch.rpm

  sudo yum update
)
