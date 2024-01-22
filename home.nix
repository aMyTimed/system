{ config, pkgs, ... }:

{
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

  programs.git = {
    enable = true;
    userName = "52638772+aMySour@users.noreply.github.com";
    userEmail = "asour";
  };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # essentials
    librewolf
    ungoogled-chromium # for webdev, chromium is good for testing and stuff
    aseprite # we could use libresprite but its missing some features
    vscode # no vscodium because i use GitHub Copilot
    peek
    inkscape-with-extensions
    blender
    vlc
    libreoffice
    kcolorchooser
    discord
    teams-for-linux
    wine
    steam

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
  ];

  programs.bash = {
    enable = true;
    enableCompletion = true;

    bashrcExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin"
    '';

    shellAliases = {
      urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
      urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
    };
  };

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
