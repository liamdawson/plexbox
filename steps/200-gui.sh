#!/usr/bin/env bash

(
  set -eu

  sudo apt install -y xorg xserver-xorg-legacy dbus-x11 alsa-utils usbmount ubuntu-drivers-common

  sudo tee "/etc/X11/Xwrapper.config" >/dev/null <"${_BASE_CONFIG_DIR}/files/Xwrapper.config"
  sudo tee "/etc/usbmount/usbmount.conf" >/dev/null <"${_BASE_CONFIG_DIR}/files/usbmount.conf"

  sudo ubuntu-drivers autoinstall
)
