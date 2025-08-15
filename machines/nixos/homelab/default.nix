{
  config,
  lib,
  pkgs,
  ...
}:
{
  # Hardware config for Intel miniPC
  hardware = {
    enableRedistributableFirmware = true;
    cpu.intel.updateMicrocode = true;
  };

  # Boot configuration for dual boot with Windows
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 3; # Show boot menu for 3 seconds
    };
    # Disable ZFS completely
    supportedFilesystems = lib.mkForce [ "ext4" "ntfs" "vfat" ];
    kernelParams = [
      "pcie_aspm=force"
      "consoleblank=60"
    ];
  };

  # Network configuration
  networking = {
    hostName = "homelab";
    # WiFi configuration
    wireless = {
      enable = true;
      networks = {
        "MagentaWLAN-LQLR" = {
          psk = "44154499609611906131";
        };
      };
    };
    firewall = {
      enable = true;
      allowPing = true;
      trustedInterfaces = [
        "tailscale0"
        "docker0"
      ];
    };
  };

  # Import sub-configurations
  imports = [
    ./homelab  # Service configurations
    ./secrets  # Simplified secrets management
    # Note: no ./filesystems since we don't use ZFS
  ];

  # Docker storage driver (ext4 compatible)
  virtualisation.docker.storageDriver = "overlay2";

  # Enable auto-upgrade
  system.autoUpgrade.enable = true;

  # Power management
  services.auto-aspm.enable = false; # Disable for now, can enable later
  powerManagement.powertop.enable = true;

  # Basic system packages
  environment.systemPackages = with pkgs; [
    pciutils
    glances
    hdparm
    smartmontools
    cpufrequtils
    powertop
  ];
}
