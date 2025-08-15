{
  config,
  lib,
  pkgs,
  ...
}:
{
  # Storage paths for services
  systemd.tmpfiles.rules = [
    "d /storage 0755 fewzy fewzy -"
    "d /storage/media 0755 fewzy fewzy -"
    "d /storage/downloads 0755 fewzy fewzy -"
    "d /storage/documents 0755 fewzy fewzy -"
    "d /storage/photos 0755 fewzy fewzy -"
  ];

  # Configure homelab settings
  homelab = {
    # Enable the homelab module
    enable = true;
    
    # Main user for services
    user = "fewzy";
    group = "fewzy";
    
    # Domain configuration
    baseDomain = "homelab.local";
  };

  # Tailscale
  services.tailscale.enable = true;
}
