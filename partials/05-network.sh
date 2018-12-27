#!/usr/bin/env bash

echo ' - setting hostname...'

echo 'plexbox.localdomain' | sudo tee /etc/hostname >/dev/null
sudo hostname -F /etc/hostname

declare -a FIREWALL_RULES=(
  "firewall-cmd --set-default-zone=home"
)

echo ' - configuring firewall transiently...'
for rule in "${FIREWALL_RULES[@]}"
do
  # shellcheck disable=SC2086
  sudo $rule
done

echo ' - configuring firewall permanently...'
for rule in "${FIREWALL_RULES[@]}"
do
  # shellcheck disable=SC2086
  sudo $rule --permanent
done
