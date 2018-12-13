{ config, pkgs, ... }:

{
  services.openssh.enable = true;
  services.openssh.permitRootLogin = "no";
  networking.firewall.allowedTCPPorts = [ 22 ];

  environment.systemPackages = with pkgs;
    [ pam_ssh_agent_auth ];

  # sudo via SSH keys? Yes please!
  security.sudo.extraconfig = ''
    auth sufficient ${pkgs.pam_ssh_agent_auth}/libexec/pam_ssh_agent_auth.so file=/etc/ssh/authorized_keys.d/%u"}
  '';

  users.mutableUsers = false;

  users.extraUsers.plexadmin = {
    isNormalUser = true;
    name = "plexadmin";
    extraGroups = ["wheel"];
    uid = 2000;
    # straight from github keys
    openssh.authorizedKeys.keys = [''
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCrRcBPq1YxBu5PSM9+LuV4FtrIqZMS0sy5MPeP+PutmpXWnkHXkOZ4EOk2azcNPoLnLlR6UXz1WDqGRhDjbZBYmxV81NsCpInEEwVMmiACdYlJV1NcKkQ2lJo4ARwsrXS/GHHIXi7o9sHYGtfgaDY4aNumRNxOm+sngxxIQl/OItjCftFIpwwYS5oe1nNmRKJj/zL0kAeFmSMuQtM8XuMq7MMQ70EG0zgI/Dg29z62t6aRtF26l1qkp4kJ/Nu+Sb/vTyjTALu31Jqwj8WHUg8UAPhJ2M/xuMAbjPjdk4vzjoZrSkplUWlu2f2Y1WEFbfaxAKObi08TYBekn8wTYQXl5qiFMpIxUt1nFvaWG2zF775vbcyzGwS5DLE24uzokfmusQ1VLTvT6Mugm26BVHuSmtABZI13MTN2AxzfwjsGlbph/A4N8y6bS4lR67wR40Ecsr87auD999tyJN5YwdH6e9OQbI7i38XYWn5y66bHYgZXEZeKee4vybDKtuHF6P7oIqc8NuRPVwm1ghFhXzhXqJrZ7e0+bKdgV/1c/c8ZkqDHA7zj3j0ouDhjB27eCUsfLGwdveyx1aJ+HsxwdYow2SYvXQIoWc7bJGMyRgvapJJCFO0XmS537rhpCWm1T6ky4MhID287fPxc2ja+eB5ZCm843ZNujHj7YHj7ly6fgw==
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCve8gcxEQKaue8XynCD8rG4KowiW3RGFJzOWhAvCi+WTRlujUE8zRLBBtsXcHCC85+N6g+ZjMLJql1JIhCncov7Lp5jBAiBi847RegvbALeux774PHGpc6A+xPMpEDbfMWjVXwbPG/B/A+hA1G/wMEYmfzkRi4DUyCS7wPBNWM9510WxNYZzjk0zA3o+/ezCuaeX4xzBFXkX84Z3J8bI79yuRBhqSm0MVGyh2R+w75YZbaSGhqgeWXhKtV0ZtVKOP6/nDaJ4kx2f2RguqF/E2yp/liyiggDGz53kGfJ5nizsr6SwB1qIh85m/rEiYmWib+ZrFBc1KyefV9Tpztc1dr0RcVRuXAfb+nxAVuZbDTL1A2nY9+g0byEVX6jm6uEaJ2yascaqyw0NXjhTsXR9v4H50z4wMp0l1vtCXHF3dawKdMIHjia+feFmopT8QZJm5omK3xemTqwRrdiWp6IdADwN3q1nqg1wKm5D702hzAchRJ6BOMINRBtkMn+2mQLjbmKiXoEm6Yxq1RKCG7w89wrm9tGdxrikJ/dxcdWQt2gY9YubrjsW3BpLqA+Y73KX3dv3STwKgr2kEscZO1OxE2kqHYYCGBWWR6BmXLtQ2FqRtehTRQD2QR0aIF1l/7S06HqfwC4KExV1bGyIiq9JCfAzp3KfS/H4VeRVln7WhduQ==
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDMztcDi7sGTxckdd6GrxI7LVVwf98rnYMvnjLWL/jxiS5Iz0F4dWu3nrms3iVVD6hY4eLaNNuAocfa0CbcAQWNddomjLn+6OnQGDpm5q5I2KaOm+xgGmpj69kyrBx4QtMq0e2OcPMTY/qBTBYbILg2pW8TEx9CjuF5RJSpKbeWE1KPJGJI7pd2D/1G5ZTvbPiq6lNk3O0VhXPRw1Jlkb2ND470vif3ymC0FeA6iLyguTZY+OYIqismu1gD1UFSWNfakIgWmvIPsoOs/Z46mj7GEk82CQF6qe5fOioPle4B9zNnXWAyxiJwEnF7TAh/vul1aeGVOT58AA61wjIYp14R
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCvadoe8lkYt2hhTVrMrLUM7ZWmE3a3GMOUstixaWaZ+tSvk6DPIcv9AoD69YNJ+eix0BTAHovhI0WHNyWRvJCJnzJMv7bXTpwN5vNe5PjSgVdQLaZKZSLBJVOr0lMzb3SlOZD4a2TfhbAhk98ItcdlOBiDSYHB2u57kwfqAZleyW4okWBZ1zRTZjaCA6yvAVYrFFvQ+jRLSkvAvuhjH+EpvF+kJvJ7OtIZm7g05fx7HBWIL/lVJnUOYm4SFjh4vOEYsF2dE+8FlwAwt3YJiykU1kSGtOcwXWdTYqEEnhqfsi6P945UagqOvf7q2PWnQrMvoICdTLPbzU3ciInVziqt
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDNqTam+/remPBe8o9g1eaRhT21Hp8FOPQ+FrYD5/9/E/pHm+0mrhx50ACCqslSvWKz2sk4urWk6HMj75icjyWXQhTMa8wiWRClX/Ni3HELEkM1o4lGaEMaY8TVhd8Vdd0RlckGpdt6e8oiYNplbnQwe/vqsz5Wgu2vhh8k02DtohGEPKtmsCB2s4FX1bpmRG6J0cImeO1umFubnkCF5tFPhnuuSW2xuKG94bYL6TYz7C2bHJXCk4/s/Bas9n4Pp+NYy/vYYk1KJWbyOmsMkfVxd0QJxvroLKAt1bwOWIwLN0+GZnoOgG3xX7/bZJirBaDnylt3dwQr0Mps11EI4QOp
    ''];
  };

  # disable root login
  users.extraUsers.root.hashedPassword = "!";
}
