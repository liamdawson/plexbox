{ config, pkgs, ... }:

{

  nixpkgs.config.packageOverrides = pkgs:
  {
    unstable = import <nixos-unstable>
      {
        config = config.nixpkgs.config;
      };
  };

  services.plex = {
    enable = true;
    openFirewall = true;
    package = pkgs.unstable.plex;
  };
}
