{ config, pkgs, got, ... }:

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

  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      theme = "dark_plus";
    };
  };

  wayland.windowManager.hyprland = {
    # Whether to enable Hyprland wayland compositor
    enable = true;
    # The hyprland package to use
    package = pkgs.hyprland;
    # Whether to enable XWayland
    xwayland.enable = true;

    # Optional
    # Whether to enable hyprland-session.target on hyprland startup
    systemd.enable = true;
  };

  wayland.windowManager.hyprland.settings = {
    "$mod" = "Super_L";
    "$terminal" = "kitty";
    misc = {
      disable_hyprland_logo = true;
      disable_splash_rendering = true;
      force_default_wallpaper = 0;
      disable_autoreload = true; # we are nixed up, we don't need this
    };
    decoration = {
      rounding = 10;
      blur = {
        enabled = true;
        size = 3;
        passes = 1;
        vibrancy = 0.1696;
      };
      drop_shadow = true;
      shadow_range = 4;
      shadow_render_power = 3;
    };
    animations = {
      enabled = true;

      bezier = [
        "myBezier, 0.05, 0.9, 0.1, 1.05"
      ];

      animation = [
        "windows, 1, 4, myBezier"
        "windowsOut, 1, 4, default, popin 80%"
        "border, 1, 5, default"
        "borderangle, 1, 8, default"
        "fade, 1, 7, default"
        "workspaces, 1, 6, default"
      ];
    };
    input = {
      follow_mouse = false;
    };
    exec-once = [
      "nm-applet --indicator"
      "waybar"
    ];
    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];
    bind =
      [
        # firefox is $mod + F, kitty is $mod + ENTER
        "$mod, F, exec, librewolf"
        ", Print, exec, grimblast copy area"
        "$mod, T, exec, foot"
        "$mod, C, exec, chromium"
        "$mod, escape, exit"
        "$mod, A, exec, rofi -show run"
        "$mod, Q, killactive"
        "$mod, E, exec, nemo"
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"
      ]
      ++ (
        # workspaces
        # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
        builtins.concatLists (builtins.genList (
            x: let
              ws = let
                c = (x + 1) / 10;
              in
                builtins.toString (x + 1 - (c * 10));
            in [
              "$mod, ${ws}, workspace, ${toString (x + 1)}"
              "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
            ]
          )
          10)
      );
  };

  services.dunst = {
    enable = true;
  };

  programs.waybar = {
    enable = true;
    systemd = {
      enable = false;
      target = "graphical-session.target";
    };
    style = ''
      * {
        font-family: "cozette", "Cozette Vector", "CozetteVector";
      }
    '';
  };

  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "cozette:size=11";
      };
    };
  };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; with got; [
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

  programs.bash = {
    enable = true;
    enableCompletion = true;

    bashrcExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin"
    '';

    shellAliases = {
      urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
      urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
      code = "codium $@"; # muscle memory
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
