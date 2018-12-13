{ config, pkgs, ... }:

{
  services.openssh.enable = true;
  services.openssh.permitRootLogin = "no";
  networking.firewall.allowedTCPPorts = [ 22 ];
}
