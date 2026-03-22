{ config, lib, pkgs, ... }:

{
  services.hyprpaper = {
    enable = true;
    package = pkgs.hyprpaper;
    settings = {
       ipc = "on";
       splash = false;

       preload = [
         "/home/pablo/Pictures/Wallpapers/highland_cattle.jpg"
         "/home/pablo/Pictures/Wallpapers/wp8.jpg"
       ];

       wallpaper = [
         "HDMI-A-1,/home/pablo/Pictures/Wallpapers/highland_cattle.jpg"
         "DP-1,/home/pablo/Pictures/Wallpapers/wp8.jpg"
       ];
    };
  };
}
