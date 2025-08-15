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
        # rocmPackages.clr.icd  # Uncomment if you need OpenCL support
        # rocmPackages.rocm-runtime  # Uncomment if you need ROCm support
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

  # Network configuration with DHCP (for now)
  networking = {
    hostName = "homelab";
    
    # Use DHCP for simplicity during setup
    useDHCP = true;
    # Add DNS servers
    nameservers = [ "8.8.8.8" "8.8.4.4" ];  # Google DNS
    
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
      allowedTCPPorts = [ 69 ];  # SSH port
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
    ./networks.nix  # Network configuration for tailscale - need .nix extension
    ../../../hardware-configuration.nix 
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
    # cpufrequtils  # Might be renamed or unavailable
    powertop
    lm_sensors  # For temperature monitoring
    # ryzen-monitor-ng  # Ryzen-specific monitoring - uncomment if available
  ];
}
