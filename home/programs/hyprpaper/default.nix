{ config, pkgs, ... }:

{

  # This one is quite different, no declarative conf for hyprpaper so we do it ourselves
  
  xdg.configFile."hypr/hyprpaper.conf".source = ./hyprpaper.conf;
  xdg.configFile."hypr/wallpaper.png".source = ./wallpaper.png;

}