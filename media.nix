{ config, pkgs, ... }:

let
  unstable = import <nixos-unstable> {};
in {
  services.plex = {
    enable = true;
    group = "users";
    openFirewall = true;
    package = unstable.plex;
  };
}
