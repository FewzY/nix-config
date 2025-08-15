{
  config,
  lib,
  pkgs,
  ...
}:
{
  # Override the secrets from _common since we don't have the private repo
  age.secrets = lib.mkForce { };
  
  # Simple password management for now
  users.users = {
    fewzy = {
      # You'll set password after first boot with: passwd fewzy
      initialPassword = "changeme";
    };
    root = {
      # You'll set password during installation
      initialPassword = "changeme";
    };
  };

  # Disable email notifications for now
  email.enable = lib.mkForce false;
  
  # Disable telegram notifications for now  
  tg-notify.enable = lib.mkForce false;

  # Override SSH config to not use persist
  services.openssh.hostKeys = lib.mkForce [
    {
      path = "/etc/ssh/ssh_host_ed25519_key";
      type = "ed25519";
    }
    {
      path = "/etc/ssh/ssh_host_rsa_key";
      type = "rsa";
      bits = 4096;
    }
  ];

  # Override git SSH config
  programs.ssh.extraConfig = lib.mkForce "";
}
