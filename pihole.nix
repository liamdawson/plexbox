{ config, pkgs, buildImage, ... }:

let file = pkgs.writeText "run-pihole" ''#!/usr/bin/env bash

IP_LOOKUP="$(ip route get 8.8.8.8 | awk '{ print $NF; exit }')"  # May not work for VPN / tun0
IPv6_LOOKUP="$(ip -6 route get 2001:4860:4860::8888 | awk '{for(i=1;i<=NF;i++) if ($i=="src") print $(i+1)}')"  # May not work for VPN / tun0
IP="$\{IP:-$IP_LOOKUP}"  # use $IP, if set, otherwise IP_LOOKUP
IPv6="$\{IPv6:-$IPv6_LOOKUP}"  # use $IPv6, if set, otherwise IP_LOOKUP

${pkgs.rkt}/bin/rkt run --insecure-options=image \
--set-env=ServerIP="$\{IP}" \
--set-env=ServerIPv6="$\{IPv6}" \
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
--mount volume=volume-etc-dnsmasq,target=/etc/dnsmasq.d \
docker://pihole/pihole:4.1'';
in {
  systemd.services."rkt-pihole" = {
    description = "pi-hole (via rkt)";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Slice = "machine.slice";
      KillMode = "mixed";
      Restart = "always";
      ExecStart = "${pkgs.bash}/bin/bash ${file}";
    };
  };
}
