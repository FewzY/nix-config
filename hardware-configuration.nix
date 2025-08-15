# This file will be replaced by the one generated on your NixOS system
# Run: sudo nixos-generate-config --root /mnt
# Then copy /mnt/etc/nixos/hardware-configuration.nix here

{ config, lib, pkgs, modulesPath, ... }:
{
  imports = [ ];
  
  # Placeholder - will be replaced with actual hardware config
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  # Placeholder filesystem - will be replaced
  fileSystems."/" = {
    device = "/dev/nvme0n1p5";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/nvme0n1p1";
    fsType = "vfat";
  };

  swapDevices = [
    { device = "/dev/nvme0n1p6"; }
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
