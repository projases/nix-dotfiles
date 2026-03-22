{ config, lib, pkgs,... }:

# let
#   inherit (nix-colors.lib-contrib { inherit pkgs; }) gtkThemeFromScheme;
#   colorScheme = nix-colors.colorSchemes.ayu-dark; # Use your preferred color scheme here
# in
{
  home.packages = with pkgs; [
    libsForQt5.qt5ct        # Tool for configuring Qt themes
    libsForQt5.qtstyleplugin-kvantum
    qt6Packages.qtstyleplugin-kvantum
    kdePackages.qt6ct
    adwaita-qt6
  ];

  qt = {
    enable = true;
    platformTheme.name = "qt6ct";
    style = {
      name = "kvantum-dark";
      package = pkgs.qt6Packages.qtstyleplugin-kvantum;
    };
  };

}
