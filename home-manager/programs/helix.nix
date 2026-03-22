{ config, lib, pkgs, ... }:

{
  programs.helix = {
  enable = true;
  settings = {
    theme = "tokyonight";
    editor.cursor-shape = {
      normal = "block";
      insert = "bar";
      select = "underline";
    };
    keys.normal = {
      space.space = "file_picker";
      space.w = ":w";
      space.q = ":q";
      esc = [ "collapse_selection" "keep_primary_selection" ];
    };

    keys.insert = {
      # Maps `jk` to exit insert mode
      j.k = "normal_mode";
    };
  };
  languages.language = [{
    name = "nix";
    auto-format = true;
    formatter.command = "${pkgs.nixfmt-rfc-style}/bin/nixfmt";
  }];

  themes = {
    autumn_night_transparent = {
      "inherits" = "autumn_night";
      "ui.background" = { };
    };
  };
};
}
