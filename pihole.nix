{ config, pkgs, buildImage, ... }:

let file = pkgs.writeText "run-pihole" ''\
  #!/usr/bin/env bash

  set -e
  set -u


  function lookup_ipv4() {
    "${pkgs.dnsutils}/bin/dig" +short myip.opendns.com @resolver1.opendns.com
  }


  IP="''${IP:-lookup_ipv4}"

  # ensure the data directories exist
  "${pkgs.coreutils}/bin/mkdir" -p /var/lib/pihole/{config,dnsmasq.d}


  ${pkgs.rkt}/bin/rkt run --insecure-options=image \
  --set-env=ServerIP="''${IP}" \
  --set-env=TZ="Australia/Melbourne" \
  --set-env=WEBPASSWORD="initialWebPassword" \
  --set-env=DNS1="1.1.1.1" \
  --set-env=DNS2="1.0.0.1" \
  --volume=volume-etc-pihole,kind=host,source=/var/lib/pihole/config,readOnly=false \
  --volume=volume-etc-dnsmasqd,kind=host,source=/var/lib/pihole/dnsmasq.d,readOnly=false \
  --port=53-tcp:53 --port=53-udp:53 \
  --port=80-tcp:4567 \
  --port=443-tcp:4568 \
  --dns=127.0.0.1 \
  --dns=1.1.1.1 \
  --dns=1.0.0.1 \
  --mount volume=volume-etc-pihole,target=/etc/pihole \
  --mount volume=volume-etc-dnsmasqd,target=/etc/dnsmasq.d \
  docker://pihole/pihole:4.1'';
in {
  systemd.services."rkt-pihole" = {
    description = "Pi-hole";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Slice = "machine.slice";
      KillMode = "mixed";
      Restart = "always";
      ExecStart = "${pkgs.bash}/bin/bash ${file}";
    };
  };

  networking.hosts."127.0.0.1" = [ "pi.hole" ];
  networking.hosts."::1" = [ "pi.hole" ];
}
