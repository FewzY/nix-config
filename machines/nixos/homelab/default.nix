{
  config,
  lib,
  pkgs,
  ...
}:
{
  # Hardware config for AMD Ryzen miniPC
  hardware = {
    enableRedistributableFirmware = true;
    cpu.amd.updateMicrocode = true;  # Changed from intel to amd
    graphics = {
      enable = true;
      # AMD integrated graphics packages
      extraPackages = with pkgs; [
        rocm-opencl-icd
        rocm-opencl-runtime
        amdvlk
      ];
      # For 32-bit applications
      extraPackages32 = with pkgs.pkgsi686Linux; [
        amdvlk
      ];
    };
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
      "amd_pstate=passive"  # Better power management for Ryzen
      "pcie_aspm=force"
      "consoleblank=60"
    ];
    kernelModules = [ "kvm-amd" ];  # AMD virtualization
  };

  # Network configuration with static IP
  networking = {
    hostName = "homelab";
    
    # Disable DHCP and set static IP
    useDHCP = false;
    
    # WiFi configuration with static IP
    wireless = {
      enable = true;
      networks = {
        "MagentaWLAN-LQLR" = {
          psk = "44154499609611906131";
        };
      };
    };
    
    # Static IP configuration
    interfaces.wlan0 = {  # Might be wlp2s0 or similar - will auto-detect
      ipv4.addresses = [{
        address = "192.168.2.100";
        prefixLength = 24;
      }];
    };
    
    # Default gateway (your router)
    defaultGateway = "192.168.2.1";  # Adjust if your router has different IP
    
    # DNS servers
    # nameservers = [ "8.8.8.8" "8.8.4.4" ];  # Google DNS, or use your router
    
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
  ];

  # Docker storage driver (ext4 compatible)
  virtualisation.docker.storageDriver = "overlay2";

  # Enable auto-upgrade
  system.autoUpgrade.enable = true;

  # Power management for Ryzen
  powerManagement = {
    enable = true;
    powertop.enable = true;
    cpuFreqGovernor = "ondemand";
  };

  # Basic system packages
  environment.systemPackages = with pkgs; [
    pciutils
    glances
    hdparm
    smartmontools
    cpufrequtils
    powertop
    lm_sensors  # For temperature monitoring
    ryzen-monitor-ng  # Ryzen-specific monitoring
  ];
}
