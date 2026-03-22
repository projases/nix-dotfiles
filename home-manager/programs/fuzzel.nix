{ config,lib, pkgs, ... }:

{
  programs.fuzzel = {
    enable = true;
    package = pkgs.fuzzel;

    settings = {
      main = {
       font = "Vegur:size=14";
       icon-theme = "kora";
       # height = 1.4;
       # width = 50;
      };
     colors = {
      background = "1f2024ff";         # bg0
      text = "a6c1e0ff";         # fg0
      match = "7289bcff";              # keyword
      selection = "c9d9ffff";   # accent
      selection-text= "1f2024ff";   # bg0
      selection-match = "7289bcff";    # keyword
      border = "5b94abff";       # bg1
     };
    };
  };

}
