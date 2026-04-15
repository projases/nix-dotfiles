{ config, pkgs, lib, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.kernelModules = [ "amdgpu" ];

  networking.hostName = "laniakea"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Madrid";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_ES.UTF-8";
    LC_IDENTIFICATION = "es_ES.UTF-8";
    LC_MEASUREMENT = "es_ES.UTF-8";
    LC_MONETARY = "es_ES.UTF-8";
    LC_NAME = "es_ES.UTF-8";
    LC_NUMERIC = "es_ES.UTF-8";
    LC_PAPER = "es_ES.UTF-8";
    LC_TELEPHONE = "es_ES.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "modesetting" ];
  hardware.graphics.enable = true;
  hardware.amdgpu.initrd.enable = true;
  # Enable AMD GPU firmware
  hardware.firmware = [ pkgs.linux-firmware ];

  # Enable virtual box
  # virtualisation.virtualbox.host = {
  # enable = true;
  # package = pkgs.virtualbox;
  # enableExtensionPack = true;
  # enableKvm = true;
  # addNetworkInterface = false;
  # };
  # virtualisation.virtualbox.guest = {
  # enable = true;
  # dragAndDrop = true;
  # clipboard = true;
  # seamless = true;
  # };
   
  #Enable docker
  virtualisation.docker.enable = true;
  
  services.gnome.gnome-online-accounts.enable = true;
  services.accounts-daemon.enable = true;
  # Enable the Pantheon Desktop Environment.
  services.desktopManager.pantheon.enable = true;

  services.displayManager.defaultSession = "pantheon-wayland";
  services.xserver.displayManager.lightdm = {
    enable = true;
    background = "/etc/lightdm/cows.jpg";
    greeters.pantheon.enable = false;
    greeters.slick = {
      enable = true;
      cursorTheme = {
        name = "catppuccin-mocha-dark-cursors";
        package = pkgs.catppuccin-cursors.mochaDark;
        size = 20;
      };
      extraConfig = ''
      [Greeter]
      background = /etc/lightdm/cows.jpg
      show-hostname = true
      '';

    };
  };

  #Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Apache Kafka
  # Enable postgreSQL
  services.postgresql = {
    enable = true;
  };
  # Enable CUPS to print documents.
  services.printing.enable = true;
 #enable bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    input = {
      General =  {
        UserspaceHID = true;
      };
    };
    package = pkgs.bluez;
  };
  services.blueman.enable = true;

  # Enable sound with pipewire.
 services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
   services.libinput.enable = true;

   security.pki.certificateFiles = [
     ./certs/uoc-chain.pem
   ];

  # Enable nginx with rtmp module
  services.nginx = {
    enable = true;
    package = (pkgs.nginx.override {
      modules = [ pkgs.nginxModules.rtmp ];
    });
    appendConfig = ''
      rtmp {
        server {
          listen 1935;
          chunk_size 4096;
          allow publish all;
          ping 30s;
          application live {
            live on;
            record off;
            push rtmp://youtube.com/live2/**************;
            push_reconnect 1s;

            hls on;
            hls_path /var/www/html/stream/hls;
            hls_fragment 3;
            hls_playlist_length 60;

            dash on;
            dash_path /var/www/html/stream/dash;
          }
        }
      }
    '';

    virtualHosts = {
      "default" = {
        listen = [ { addr = "0.0.0.0"; port = 80; } ];
        locations."/" = {
          root = "/var/www/html";
        };
      };

      "rtmp-stats" = {
        listen = [ { addr = "0.0.0.0"; port = 8080; } ];
        locations."/stat" = {
          extraConfig = ''
            rtmp_stat all;
            rtmp_stat_stylesheet stat.xsl;
          '';
        };
        locations."/stat.xsl" = {
          root = "/var/www/html/rtmp";
        };
        locations."/control" = {
          extraConfig = ''
            rtmp_control all;
          '';
        };
      };

      #HLS/DASH streaming virtual host
      "streaming-video" = {
        listen = [ { addr = "0.0.0.0"; port = 8088; } ];
        locations."/" = {
          root = "/var/www/html/stream";
          extraConfig = ''
            add_header Access-Control-Allow-Origin *;
            types {
              application/dash+xml mpd;
              application/vnd.apple.mpegurl m3u8;
            }
          '';
        };
      };
    };
  };

  systemd.services.nginx.serviceConfig = {
    ReadWritePaths = [ "/var/www/html" ];
  };

  # Group needed for configuring udev rules for ZSA keyboards
  users.groups.plugdev = { };
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.pablo = {
    isNormalUser = true;
    description = "Pablo Rojas Espejel";
    extraGroups = [ "docker" "plugdev" "networkmanager" "wheel" "video" "input" "render" "vboxusers" "wireshark" ];
    shell = pkgs.fish;
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  
  programs.direnv.enable = true;
  programs.fish.enable = true;
  programs.hyprland.enable = true;
  programs.niri.enable = true;
  programs.dconf.enable = true;
  programs.zsh.enable = true;
  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
    dumpcap.enable = true;
  };
  programs.java = {
    enable = true;
    package = pkgs.jdk;
  };
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    glib
    gtk3
    mesa
    libGL
    libXxf86vm
    libXi
    libXrandr
    libXcursor
    libX11
    libXtst
  ];

  # services.hypridle = {
  #   enable = true;
  #   package = pkgs.hypridle;
  # };
  #Shells
  environment.shells = with pkgs; [fish zsh bash nushell ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    git
    ripgrep
    fd
    bat
    fzf
    libusb1
    webkitgtk_4_1
    wally-cli
    keymapp

    # Docker
    docker-compose

    # C 
    gcc
    gnumake
    clang
    gdb
    llvmPackages.libclang
    lldb
    cmake
    clang-tools
    bear

    # Nix
    alejandra
    nil

    # JS 
    nodejs
    nodePackages.typescript
    nodePackages.typescript-language-server
    copilot-language-server

    # Haskell 
    ghc
    cabal-install
    haskellPackages.haskell-language-server
    hlint
    ghcid
    haskellPackages.stack

    # Apps
    neovim
    vscode-fhs
    warp-terminal
    kitty

    # Java
    maven
    jdt-language-server
    clojure
    leiningen
    postgresql_jdbc
    cacert
    gradle
    
    inputs.noctalia.packages.${system}.default
    # Emacs
    # emacs-pgtk

  ];
  fonts.packages = with pkgs; [
      fira
      fira-code-symbols
      dina-font
      roboto
      corefonts
      nerd-fonts.noto
      nerd-fonts.intone-mono
      nerd-fonts.victor-mono
      nerd-fonts.jetbrains-mono
      nerd-fonts.hasklug
      nerd-fonts.fira-code
      nerd-fonts.lilex
      vista-fonts
      font-awesome
      aileron
      helvetica-neue-lt-std
      lato
      tenderness
      vegur
      azeret-mono
      texlivePackages.inter
      julia-mono
      sf-mono-liga-bin
    ];
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  environment.variables = {
    QT_QPA_PLATFORMTHEME = "qt6ct";
  };

  # List services that you want to enable:
  # Add the ZSA udev rules (for flashing keyboards)
  services.udev.extraRules = ''
    # Rules for Oryx web flashing and live training
    KERNEL=="hidraw*", ATTRS{idVendor}=="16c0", MODE="0664", GROUP="plugdev"
    KERNEL=="hidraw*", ATTRS{idVendor}=="3297", MODE="0664", GROUP="plugdev"

    # Legacy rules for live training over webusb (Not needed for firmware v21+)
    # Rule for all ZSA keyboards
    SUBSYSTEM=="usb", ATTR{idVendor}=="3297", GROUP="plugdev"
    # Rule for the Ergodox EZ
    SUBSYSTEM=="usb", ATTR{idVendor}=="feed", ATTR{idProduct}=="1307", GROUP="plugdev"

    # Wally Flashing rules for the Ergodox EZ
    ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789B]?", ENV{ID_MM_DEVICE_IGNORE}="1"
    ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789A]?", ENV{MTP_NO_PROBE}="1"
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789ABCD]?", MODE:="0666"
    KERNEL=="ttyACM*", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789B]?", MODE:="0666"
  '';
  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
  # Enable flatpak support
  services.flatpak.enable = true;
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  system.stateVersion = "24.05"; 

}
