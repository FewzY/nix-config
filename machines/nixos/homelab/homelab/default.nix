{
  config,
  lib,
  pkgs,
  ...
}:
{
  # Storage paths for services
  systemd.tmpfiles.rules = [
    "d /storage 0755 homelab homelab -"
    "d /storage/media 0755 homelab homelab -"
    "d /storage/downloads 0755 homelab homelab -"
    "d /storage/documents 0755 homelab homelab -"
    "d /storage/photos 0755 homelab homelab -"
  ];

  # Configure homelab settings
  homelab = {
    # Enable the homelab module
    enable = true;
    
    # Main user for services
    user = "homelab";
    group = "homelab";
    
    # Domain configuration
    baseDomain = "homelab.local";
  };

  # Tailscale
  services.tailscale.enable = true;
}
