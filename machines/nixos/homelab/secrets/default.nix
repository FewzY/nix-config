{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  # Override all age secrets to use plain text dummy values
  age = {
    identityPaths = lib.mkForce [ "/etc/nixos/age/age.key" ];
    
    secrets = {
      hashedUserPassword = {
        file = "${inputs.secrets}/hashedUserPassword.age";
        mode = lib.mkForce "0600";
      };
      tailscaleAuthKey = {
        file = "${inputs.secrets}/tailscaleAuthKey.age";
        mode = lib.mkForce "0600";
      };
      smtpPassword = {
        file = "${inputs.secrets}/smtpPassword.age";
        mode = lib.mkForce "0600";
        owner = lib.mkForce "root";
        group = lib.mkForce "root";
      };
      duckDNSDomain = {
        file = "${inputs.secrets}/duckDNSDomain.age";
        mode = lib.mkForce "0600";
      };
      duckDNSToken = {
        file = "${inputs.secrets}/duckDNSToken.age";
        mode = lib.mkForce "0600";
      };
      tgNotifyCredentials = {
        file = "${inputs.secrets}/tgNotifyCredentials.age";
        mode = lib.mkForce "0600";
      };
      adiosBotToken = {
        file = "${inputs.secrets}/adiosBotToken.age";
        mode = lib.mkForce "0600";
      };
      # Add other secrets from _common/secrets
      sambaPassword = {
        file = "${inputs.secrets}/sambaPassword.age";
        mode = lib.mkForce "0600";
      };
      cloudflareDnsApiCredentials = {
        file = "${inputs.secrets}/cloudflareDnsApiCredentials.age";
        mode = lib.mkForce "0600";
      };
      resticBackblazeEnv = {
        file = "${inputs.secrets}/resticBackblazeEnv.age";
        mode = lib.mkForce "0600";
      };
      gitIncludes = {
        file = "${inputs.secrets}/gitIncludes.age";
        mode = lib.mkForce "0600";
      };
    };
  };

  # Just set root password
  users.users.root.initialPassword = lib.mkForce "changeme";
  users.users.fewzy.initialPassword = lib.mkForce "changeme";
  
  # Disable services that require real secrets
  services.tailscale.enable = lib.mkForce false;
  services.duckdns.enable = lib.mkForce false;
  tg-notify.enable = lib.mkForce false;
  email.enable = lib.mkForce false;
}
