{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Broadcom WiFi drivers - BCM4360 requires proprietary driver
  # The open-source b43 driver doesn't support 802.11ac chips like BCM4360
  hardware.enableRedistributableFirmware = true;
  
  # Use the proprietary broadcom-sta driver for BCM4360
  boot.extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];
  
  # Blacklist the conflicting open-source drivers
  boot.blacklistedKernelModules = [ "b43" "b43legacy" "ssb" "bcm43xx" "brcm80211" "brcmfmac" "brcmsmac" "bcma" ];
  
  networking.hostName = "macnix"; # Define your hostname.
  

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

  # Enable the Pantheon Desktop Environment.
  services.desktopManager.pantheon.enable = true;
  services.xserver.displayManager.lightdm.greeters.pantheon.enable = false;

  services.xserver.displayManager.lightdm = {
    enable = true;
    background = "/etc/lightdm/sheep.jpg";
    greeters.slick = {
      enable = true;
      cursorTheme = {
        name = "catppuccin-mocha-dark-cursors";
        package = pkgs.catppuccin-cursors.mochaDark;
        size = 20; # Size of the cursor theme
      };
    };
  };

  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  # Enable Niri
  programs.niri.enable = true;
  
  # Enable required services for Wayland
  services.gnome.gnome-keyring.enable = true;
  security.polkit.enable = true;
  
  # XDG portal for screencasting
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
  };

 # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  #Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  services.blueman.enable = true;

  services.logind.settings.Login = {
    HandleLidSwitchDocked = "suspend";
    HandleLidSwitchExternalPower = "suspend";
    HandlelidSwitch = "suspend";
  };
  services.postgresql = {
    enable = true;
  };

  services.libinput.enable = true;
  hardware.facetimehd.enable = true;
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    extraConfig.pipewire = {
      "99-bluetooth-quality" = {
        "context.properties" = {
          "bluez5.enable-sbc-xq" = true;
          "bluez5.enable-msbc" = true;
          "bluez5.enable-hw-volume" = true;
          "bluez5.codecs" = [ "sbc" "sbc_xq" "aac" ];
        };
      };
    };
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.pablo = {
    isNormalUser = true;
    shell = pkgs.zsh; 
    description = "Pablo Rojas";
    extraGroups = [ "networkmanager" "wheel" "video" "input" "render" ];
    packages = with pkgs; [
    ];
  };

  programs.dconf.enable = true;
  programs.zsh.enable = true;
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # Allow insecure broadcom-sta driver (needed for BCM4360)
  nixpkgs.config.permittedInsecurePackages = [
    "broadcom-sta-6.30.223.271-57-6.12.41"
    "electron-36.9.5"
    "broadcom-sta-6.30.223.271-59-6.12.57"
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim 
    #  wget
    ghc
    cabal-install
    haskell-language-server
    gcc 
    hlint
    ghcid
    haskellPackages.stack
    facetimehd-firmware
    facetimehd-calibration
    emacs-pgtk
    warp-terminal
    wget
    ripgrep
    fd
    bat
    fzf
    git
    inputs.noctalia.packages.${system}.default
    tree-sitter
    tree-sitter-grammars.tree-sitter-bash
    tree-sitter-grammars.tree-sitter-c
    tree-sitter-grammars.tree-sitter-css
    tree-sitter-grammars.tree-sitter-html
    tree-sitter-grammars.tree-sitter-java
    tree-sitter-grammars.tree-sitter-javascript
    tree-sitter-grammars.tree-sitter-json
    tree-sitter-grammars.tree-sitter-python
    tree-sitter-grammars.tree-sitter-rust
    clang-tools
    lld
    wireguard-tools
    protonvpn-gui
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.victor-mono
    nerd-fonts.intone-mono
  ];
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; 

}

