{ config, lib, pkgs, ... }:

{
  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    git = true;
    icons = "always";
    colors = "always";
    extraOptions = [ "--no-quotes" ];
  };

}
