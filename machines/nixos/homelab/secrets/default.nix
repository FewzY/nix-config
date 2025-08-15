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
    identityPaths = [ "/etc/nixos/age/age.key" ];
    
    secrets = {
      hashedUserPassword = {
        file = "${inputs.secrets}/hashedUserPassword.age";
        mode = "0600";
      };
      tailscaleAuthKey = {
        file = "${inputs.secrets}/tailscaleAuthKey.age";
        mode = "0600";
      };
      smtpPassword = {
        file = "${inputs.secrets}/smtpPassword.age";
        mode = "0600";
      };
      duckDNSDomain = {
        file = "${inputs.secrets}/duckDNSDomain.age";
        mode = "0600";
      };
      duckDNSToken = {
        file = "${inputs.secrets}/duckDNSToken.age";
        mode = "0600";
      };
      tgNotifyCredentials = {
        file = "${inputs.secrets}/tgNotifyCredentials.age";
        mode = "0600";
      };
      adiosBotToken = {
        file = "${inputs.secrets}/adiosBotToken.age";
        mode = "0600";
      };
    };
  };

  # Just set root password
  users.users.root.initialPassword = lib.mkForce "changeme";
  users.users.fewzy.initialPassword = lib.mkForce "changeme";
}
