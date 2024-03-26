{ config, pkgs, ... }:

{

  programs.waybar = {
    enable = true;
    systemd = {
      enable = false;
      target = "graphical-session.target";
    };
    settings = {
      mainBar = {
        layer = "top";
        modules-left = [
          "hyprland/workspaces"
        ];
        modules-center = [
          "hyprland/window"
        ];
        modules-right = [
          "battery"
          "clock"
        ];
        battery = {
          format = "{capacity}% Power ({time})";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
        };
        clock = {
          format = "{:%a, %d. %b  %H:%M}";
        };
      };  
    };
    style = (builtins.readFile ./waybar.css);
  };

}