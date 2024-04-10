{ config, pkgs, ... }:

{

  programs.neovim = {
    enable = true;
    settings = {
      main = {
        font = "cozette:size=11";
        pad = "10x10 center";
      };
      colors = {
        alpha = 0.5;
      };
    };
  };

}