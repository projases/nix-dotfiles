{
  config,
  pkgs,
  inputs,
  zen-browser,
  ...
}:

let
  doomIcon = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/eccentric-j/doom-icon/master/cute-doom/doom.png";
    sha256 = "b4f974ff9530c0d7781bbb89998a501be7f00fed4fb6ce8f210395ff4b435b96";
  };
in

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "pablo";
  home.homeDirectory = "/home/pablo";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  # nixpkgs.config.allowUnfree = true;

  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.

  home.stateVersion = "23.11"; # Please read the comment before changing.
  imports = [
    ./programs
    ./services
    inputs.noctalia.homeModules.default
    # nix-colors.homeManagerModules.default
  ];
  home.pointerCursor = {
    gtk.enable = true;
    name = "catppuccin-mocha-dark-cursors";
    package = pkgs.catppuccin-cursors.mochaDark;
    size = 20;
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "Adwaita-dark";
      icon-theme = "kora";
      cursor-theme = "catppuccin-mocha-dark-cursors";
    };
    "org/pantheon/desktop/gala/appearance" = {
      dark-theme = true;
    };
  };
  # services.emacs = {
  #   enable = true;
  #   package = pkgs.emacs;
  #   startWithUserSession = true;
  # };
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;
  
    extraPackages = epkgs: [
      epkgs.treesit-grammars.with-all-grammars
    ];
  };

  # services.blueman-applet.enable = true;
  #(import stylix).homeManagerModules.stylix
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [

    #terminal
    zsh
    zsh-history-substring-search
    zsh-syntax-highlighting
    zsh-you-should-use
    oh-my-zsh
    starship
    cmake
    gnumake
    libgcc
    bottom
    rclone
    nushell
    yazi
    fastfetch
    tree
    valgrind
    ispell
    ghostty
    nodejs
    yasm
    gajim
    nodePackages.katex
    nix-prefetch-git
    nix-prefetch-github
    eza
    zoxide
    net-tools
    whois
    iproute2
    wl-clipboard
    gh

    #Appearance
    kora-icon-theme
    dconf
    lxappearance
    gnome-tweaks
    catppuccin-cursors.mochaDark

    # Emacs
    #Doom dependencies
    gnutls
    imagemagick
    zstd
    alejandra
    chemacs2
    libtool
    plantuml
    graphviz
    pandoc

    #Niri
    xwayland-satellite
    swayidle

    
    #daemons
    mako
    mpd

    #Hyprland
    pamixer
    waybar
    hyprpaper
    fuzzel
    wlogout
    wleave
    networkmanagerapplet
    brightnessctl
    playerctl
    glib
    gsettings-desktop-schemas
    hyprcursor
    nautilus

    #Apps
    alacritty
    kitty
    spotify
    vlc
    gnome.gvfs
    nyxt
    racket
    webcord
    helix
    # julia
    zen-browser.packages."${pkgs.system}".default
    transmission_4
    obs-studio
    xournalpp
    pdfarranger
    wasistlos
    texlivePackages.latexmk
    texliveFull
    openboard
    brave
    krita
    jetbrains.idea-oss
    jetbrains.idea
    geany
    kdbg
    syncthing
    pantheon-tweaks
    openjfx21
    libGL
    gtk3
    zotero
    weechat
    (python3.withPackages (ps: [ ps.jupyter ps.matplotlib ]))
    wireguard-tools
    protonvpn-gui
    unzip
    pgadmin4-desktopmode
  ];

    # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  
  programs.ghostty = {
    enableZshIntegration = true;
    enableFishIntegration = true;
  };

  programs.kitty = {
    enable = true;
    font.name = "IntoneMono Nerd Font";
    font.size = 14;
    themeFile = "ayu";
    shellIntegration.enableFishIntegration = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    autosuggestion.strategy = [
      "history"
      "completion"
    ];
    historySubstringSearch.enable = true;
    syntaxHighlighting.enable = true;

    history.size = 10000;
    history.ignoreAllDups = true;
    history.path = "$HOME/.zsh_history";
    history.ignorePatterns = [
      "rm *"
      "pkill *"
      "cp *"
    ];

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git" # also requires `programs.git.enable = true;`
        "z"
        "you-should-use"
      ];
    };
    shellAliases = {
      ll = "ls -l";
      ls = "eza --icons=always --no-quotes";
      tree = "eza --icons=always --tree --no-quotes";
      nix-shell = "nix-shell --command zsh";
      update = "sudo nixos-rebuild switch";
    };
  };

  programs.fish = {
    enable = true;
    package = pkgs.fish;
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
  };
  programs.fzf = {
    enable = true;              # Fuzzy command history search
    enableBashIntegration = true; # Tab completion for Bash
    enableZshIntegration = true;
  };
  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    git = true;
    icons = "always";
    colors = "always";
    extraOptions = [ "--no-quotes" ];
  };
  programs.bat = {
    enable = true;
    extraPackages = with pkgs.bat-extras; [
      batdiff
      batman
      prettybat
      batgrep
    ];
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';

    #-------------  Chemacs2 configuration -------------------------------
    ".emacs.d".source = "${pkgs.chemacs2}/share/site-lisp/chemacs2/";

    ".emacs-profiles.el".text = ''
      (
      ("default" . ((user-emacs-directory . "~/.emacs.default")
               (server-name . "doom")
               (env . (("DOOMDIR" . "~/.config/doom")))))

      ;; Learning profile → Plain Emacs config
      ("learn" . ((user-emacs-directory . "~/.emacs.learn")
               (server-name . "learn")))
      )
    '';
    #--------------------------------------------------------------------------
    "/home/pablo/.local/share/applications/emacsclient.desktop".text = ''
      [Desktop Entry]
      Name=Emacs Client
      Comment=Edit text
      Exec=emacsclient -c -s doom -a emacs
      Icon=${doomIcon}
      Terminal=false
      Type=Application
      Categories=Utility;TextEditor;
      MimeType=text/plain;
    '';

    # starship configuration
    "${config.home.homeDirectory}/.config/starship.toml".source = ./programs/starship.toml;

    # slick greeter configuration
    ".config/lightdm/slick-greeter.conf".text = ''
      [Greeter]
      background = "/home/pablo/Pictures/Wallpapers/cows.jpg"
      cursor-theme-name = "catppuccin-mocha-dark-cursors"
    '';

    "/home/pablo/.local/share/applications/emacs.desktop".text = ''
      [Desktop Entry]
      Name=Emacs
      Comment=Edit text
      Exec=emacs %F
      Icon=${doomIcon}
      Terminal=false
      Type=Application
      Categories=Utility;TextEditor;
      MimeType=text/plain;
    '';

  };
  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/pablo/etc/profile.d/hm-session-vars.sh
  #

  home.sessionVariables = {
    HDY_COLOR_SCHEME = "dark";
    GTK_THEME = "Adwaita-dark";
    QT_QPA_PLATFORMTHEME = "qt6ct";
    QT_STYLE_OVERRIDE = "kvantum-dark";
    EDITOR = "emacs";
    QS_ICON_THEME="kora";

  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
