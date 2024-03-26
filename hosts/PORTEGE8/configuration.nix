{ config, pkgs, ... }:

{
  imports = [
    ../../nixos/configuration.nix
  ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "PORTEGE8";

  services.udev.extraRules = ''
    ATTRS{name}=="*DualPoint Stick", ENV{ID_INPUT}="", ENV{ID_INPUT_MOUSE}="", ENV{ID_INPUT_POINTINGSTICK}=""
  '';
}