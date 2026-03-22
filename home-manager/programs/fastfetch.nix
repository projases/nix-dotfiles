{ config, lib, pkgs, ... }:

{
  programs.fastfetch = {
  enable = true;
  package = pkgs.fastfetch;
  settings = {
    logo = {
      # type = "kitty-direct";
      source = "/home/pablo/Pictures/icons/nixos-logo.png";
      # preserveAspectRadio = true;
      padding = {
        right = 1;
      };
  };

  display = {
    size = {
      binaryPrefix = "si";
    };
    color = "blue";
    separator = "  ";
  };
  modules = [
    "break"
    "break"
    "break"
    {
      type = "os";
      key = "OS";
    }
    {
      type = "host";
      key = "Machine";
    }
    "cpu"

    {
      type = "kernel";
      key = "Kernel";

    }
    "break"
    {
      type = "wm";
      key = "WM";
      keyColor = "blue";
    }
    {
      type = "terminal";
      key = "Terminal";
    }
    {
      type = "shell";
      key = "Shell ";
    }
    "break"
    "font"
    "icons"
    "theme"
    # {
    #   type = "datetime";
    #   key = "Date";
    #   format = "{1}-{3}-{11}";
    # }
    # {
    #   type = "datetime";
    #   key = "Time";
    #   format = "{14}:{17}:{20}";
    # }
    {
      type = "media";
      key = "Now Playing";
      format = "{?artist}{artist} - {?}{title}";

    }
    "break"
  ];
  };
  };
}
