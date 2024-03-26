{ config, pkgs, ... }:

{

  programs.git = {
    enable = true;
    userEmail = "52638772+aMySour@users.noreply.github.com";
    userName = "asour";
  };

}