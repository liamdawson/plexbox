{ config, pkgs, ... }:

{
  networking = {
    hostName = "plexbox";
    firewall.enable = true;
    wireless.enable = true;
    hosts = {
      "127.0.0.1" = [ "localhost" "plexbox" ];
      "::1" = [ "localhost" "plexbox" ];
    };
  };

  environment.systemPackages = with pkgs;
    [ wpa_supplicant ];
}
