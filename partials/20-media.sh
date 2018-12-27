#!/usr/bin/env bash

(
  set -e
  set -u

  PUBLIC_PLEX_MEDIA_SERVER_URL="https://downloads.plex.tv/plex-media-server/1.14.1.5488-cc260c476/plexmediaserver-1.14.1.5488-cc260c476.x86_64.rpm"

  if ! rpm -q plexmediaserver >/dev/null 2>&1
  then
    sudo yum install -y "$PUBLIC_PLEX_MEDIA_SERVER_URL"
    sudo systemctl start plexmediaserver
  fi
)
