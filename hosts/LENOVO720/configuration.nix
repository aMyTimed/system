{ config, pkgs, ... }:

{
  imports = [
    ../../nixos/configuration.nix
  ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "LENOVO720";

  boot.kernelParams = [ "nvidia.NVreg_PreserveVideoMemoryAllocations=1" ];

  hardware.nvidia.powerManagement.enable = true;

  # Making sure to use the proprietary drivers until the issue above is fixed upstream
  hardware.nvidia.open = false;
}