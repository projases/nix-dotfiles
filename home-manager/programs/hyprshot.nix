{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    hyprshot
    jq
    grim
    slurp
    wl-clipboard
    libnotify
  ];

  # Set environment variable for screenshot dir
  home.sessionVariables = {
    HYPRSHOT_DIR = "$HOME/Pictures/Screenshots";
  };
}
