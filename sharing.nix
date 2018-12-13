{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs;
    [ letsencrypt ];

  services.samba = {
    enable = true;

    extraConfig = ''
      workgroup = WORKGROUP
      server string = Plexbox data
      netbios name = PLEXBOX
      hosts deny = 0.0.0.0/0
      hosts allow = 192.168.0.0/16 10.0.0.0/8 127.0.0.0/8
      hosts allow = 0.0.0.0/0
      guest account = nobody
      map to guest = Bad User
      usershare allow guests = yes

      server signing = mandatory
      client signing = mandatory
      server min protocol = SMB3
      server max protocol = SMB3
      client min protocol = SMB3
      client max protocol = SMB3
    '';
    shares = {
      "media" = {
        path = "/media/data";
        browseable = "yes";
        writeable = "yes";
        "read only" = "no";
        "guest ok" = "yes";
        "create mask" = "0664";
        "directory mask" = "2775";
        "directory security mask" = "2775";
        "force directory mode" = "2775";
        "force directory security mode" = "2775";
        "force user" = "nobody";
        "force group" = "users";
      };
    };
  };

  networking.firewall.allowPing = true;
  networking.firewall.allowedTCPPorts = [ 445 139 ];
  networking.firewall.allowedUDPPorts = [ 137 138 ];
}
