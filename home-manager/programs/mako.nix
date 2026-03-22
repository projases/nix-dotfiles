{
  pkgs,
  self,
  lib,
  hostname,
  ...
}:
let
  theme = import "${self}/lib/theme" { inherit pkgs; };
in
{
  services = {
    mako = {
      enable = true;
      # catppuccin.enable = true;
      settings = {
        actions = true;
        anchor = "top-right";
        border-radius = 8;
        border-size = 1;
        default-timeout = 10000;
        font = "Vegur";
        # iconPath = "${theme.iconTheme.iconPath}";
        icons = true;
        layer = "overlay";
        max-visible = 3;
        padding = "10";
        width = 300;
        background-color = "#282b33";
        border-color = "#e1c1ee";
    };
    };
  };
}
