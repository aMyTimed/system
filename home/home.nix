{ config, pkgs, got, ... }:

{
  imports =
    [
      ./programs
    ];

  home.username = "someone";
  home.homeDirectory = "/home/someone";

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  # set cursor size and dpi for 4k monitor
  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };

  services.dunst = {
    enable = true;
  };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; with got; [
    pipes-rs
    hyprpaper
    yad
    grimblast
    rofi
    wev
    # essentials
    librewolf
    #ungoogled-chromium # for webdev, chromium is good for testing and stuff
    #aseprite # we could use libresprite but its missing some features
    libresprite
    libnotify
    glib
    vscodium
    peek
    inkscape-with-extensions
    blender
    vlc
    libreoffice
    kitty
    kcolorchooser
    discord
    teams-for-linux
    wine
    steam
    imagemagick

    plank

    # programming languages
    rustc
    cargo
    bun
    nodejs

    gcc
    stdenv
    cmake
    extra-cmake-modules

    # utils
    ffmpeg
    neofetch # gotta flex the NixOS somehow
    glow # markdown previewer in terminal
    xautoclick

    # archives
    zip
    unzip

    # networking tools
    nmap # A utility for network discovery and security auditing

    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor

    retroarchFull

    yt-dlp

    google-chrome

    (pkgs.buildEnv { name = "got"; paths = [ got ]; })
  ];

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
