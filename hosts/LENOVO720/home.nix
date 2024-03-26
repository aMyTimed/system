{ config, pkgs, got, ... }:

{
  imports =
    [
      ../../home/home.nix
    ];

  wayland.windowManager.hyprland.settings = {
    monitor = [
      "eDP-1, 1920x1080, 0x0, 1"
      "DP-2, 1920x1080, 1920x0, 1"
      "DP-3, 1920x1080, 3840x0, 1"
    ];
  };
}