#!/usr/bin/env bash

(
  set -eu

  sudo apt install -y alsa-utils usbmount nouveau-firmware xserver-xorg-video-nouveau
  sudo apt install -y --no-install-recommends xubuntu-desktop

  sudo tee "/etc/X11/Xwrapper.config" >/dev/null <"${_BASE_CONFIG_DIR}/files/Xwrapper.config"
  sudo tee "/etc/usbmount/usbmount.conf" >/dev/null <"${_BASE_CONFIG_DIR}/files/usbmount.conf"
)
