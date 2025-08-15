{
  config,
  lib,
  pkgs,
  ...
}:
let
  hl = config.homelab;
in
{
  # Enable ALL services (you can disable later)
  homelab = {
    # Main user for services
    user = "fewzy";
    group = "fewzy";
    
    # Storage paths (will be on your HDDs later)
    dataDirs = {
      media = "/storage/media";
      downloads = "/storage/downloads";
      documents = "/storage/documents";
    };

    # Domain configuration (you can change this later)
    baseDomain = "homelab.local";
    
    # Enable services
    arr = {
      enable = true;
      sonarr.enable = true;
      radarr.enable = true;
      prowlarr.enable = true;
      bazarr.enable = true;
      jellyseerr.enable = true;
      lidarr.enable = true;
    };

    audiobookshelf.enable = true;
    
    backup = {
      enable = false; # Enable after setting up storage
    };

    homepage.enable = true;
    
    immich = {
      enable = true;
      photosPath = "/storage/photos";
    };

    jellyfin = {
      enable = true;
      openFirewall = true;
    };

    keycloak.enable = false; # Complex, enable later if needed
    
    microbin.enable = true;
    miniflux.enable = true;
    navidrome.enable = true;
    
    ocis.enable = false; # Complex, enable later if needed
    
    paperless-ngx = {
      enable = true;
      documentPath = "/storage/documents";
    };

    radicale.enable = true;
    
    sabnzbd.enable = true;
    deluge.enable = true;
    
    slskd.enable = true;
    
    smarthome = {
      homeassistant.enable = false; # Enable if you have smart home devices
      raspberrymatic.enable = false;
    };

    uptime-kuma.enable = true;
    
    vaultwarden = {
      enable = true;
      openFirewall = true;
    };

    wireguard-netns.enable = false; # Complex VPN setup, configure later
    
    # Network and routing
    networks.enable = true;
    samba.enable = true;
  };

  # Create storage directories
  systemd.tmpfiles.rules = [
    "d /storage 0755 fewzy fewzy -"
    "d /storage/media 0755 fewzy fewzy -"
    "d /storage/downloads 0755 fewzy fewzy -"
    "d /storage/documents 0755 fewzy fewzy -"
    "d /storage/photos 0755 fewzy fewzy -"
  ];

  # Tailscale configuration
  services.tailscale.enable = true;
}
