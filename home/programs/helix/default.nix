{ config, pkgs, ... }:

{

  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      theme = "dark_plus_transparent";
    };
    themes = {
      dark_plus_transparent = {
        "inherits" = "dark_plus";
        "ui.background" = {};  
      };
    };
  };

}