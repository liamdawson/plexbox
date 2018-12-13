{ config, pkgs, ... }:

{
  networking = {
    hostName = "plexbox";
    firewall.enable = true;
    wireless.enable = true;
  };

  environment.systemPackages = with pkgs;
    [ wpa_supplicant ];
}
