#!/usr/bin/env bash

(
  set -e
  set -u

  PUBLIC_PLEX_MEDIA_SERVER_URL="https://downloads.plex.tv/plex-media-server/1.14.1.5488-cc260c476/plexmediaserver_1.14.1.5488-cc260c476_amd64.deb"

  curl -sSLo /tmp/plex.deb "$PUBLIC_PLEX_MEDIA_SERVER_URL"
  sudo dpkg -i /tmp/plex.deb

  sudo systemctl enable --now plexmediaserver
)
