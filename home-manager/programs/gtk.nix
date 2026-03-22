{ config, lib, pkgs, ... }:


# let
#   inherit (nix-colors.lib-contrib { inherit pkgs; }) gtkThemeFromScheme;
#   colorScheme = nix-colors.colorSchemes.ayu-dark;
# in
# {
#   home.packages = with pkgs; [
#     dconf
#   ];


  # dconf = {
  #   enable = true;
  #   settings = {
  #     "org/gnome/desktop/interface" = {
  #       color-scheme = "prefer-dark";
  #     };
  #   };
  # };
{
  gtk = {
     enable=true;

     # theme = {
     #   name = "Adwaita-dark";
     #   package = pkgs.pantheon.elementary-gtk-theme;
     #   package = gtkThemeFromScheme { scheme = colorScheme; };
     # };
     iconTheme = {
       name = "kora";
       package = pkgs.kora-icon-theme;
     };
     cursorTheme = {
       name = "catppuccin-mocha-dark-cursors";
       package = pkgs.catppuccin-cursors.mochaDark;
       size = 20;
     };
     font = {
       name = "Inter";
       size = 12;
       package = pkgs.texlivePackages.inter;
     };

     gtk4.extraConfig = {
       gtk-application-prefer-dark-theme = true;
     };
     gtk3.extraConfig = {
       gtk-application-prefer-dark-theme = true;
     };

    };

}
