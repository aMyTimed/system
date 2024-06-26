{ lib, config, pkgs, nixpkgs, ... }:

{
  imports = [
    ../../nixos/configuration.nix
    (nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix")
  ];

  isoImage.squashfsCompression = "gzip -Xcompression-level 1";

  virtualisation.vmVariant = {
    virtualisation = {
      memorySize = 4096;
      cores = 2;
    };
  };

  networking.networkmanager.enable = lib.mkForce false;

  networking.hostName = "IMAGE"; # live image of the system

  # the udev rule from PORTEGE8 so we can boot on that without the issues
  services.udev.extraRules = ''
    ATTRS{name}=="*DualPoint Stick", ENV{ID_INPUT}="", ENV{ID_INPUT_MOUSE}="", ENV{ID_INPUT_POINTINGSTICK}=""
  '';
}