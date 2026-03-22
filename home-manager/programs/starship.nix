{ config, lib, pkgs, ... }:
# https://claude.ai/public/artifacts/af63a46a-9c81-4edc-b897-dafb5f4591d5
{
  programs.starship = {
    enable = true;
    package = pkgs.starship;
    settings = ''
      format = """
      [░▒▓](#90a6db)\
      [  ](fg:#1f2024 bg:#90a6db)\
      [](bg:#819cd6 fg:#90a6db)\
      $directory\
      [](fg:#819cd6 bg:#7289bc)\
      $git_branch\
      $git_status\
      [](fg:#7289bc bg:#5b94ab)\
      $nodejs\
      $rust\
      $golang\
      $php\
      $haskell\
      $java\
      $c\
      $nix_shell\
      [](fg:#5b94ab bg:#34373e)\
      $time\
      [ ](fg:#34373e)\
      \n$character"""

      [directory]
      style = "fg:#d3d3d3 bg:#819cd6"
      format = "[ $path ]($style)"
      truncation_length = 3
      truncation_symbol = "…/"

      [directory.substitutions]
      "Documents" = "󰈙 "
      "Downloads" = " "
      "Music" = " "
      "Pictures" = " "

      [git_branch]
      symbol = ""
      style = "bg:#7289bc"
      format = '[[ $symbol $branch ](fg:#d3d3d3 bg:#7289bc)]($style)'


      [git_status]
      style = "bg:#7289bc"
      format = '[[($all_status$ahead_behind )](fg:#d3d3d3 bg:#7289bc)]($style)'

      [nodejs]
      symbol = ""
      style = "bg:#5b94ab"
      format = '[[ $symbol ($version) ](fg:#d3d3d3 bg:#5b94ab)]($style)'

      [rust]
      symbol = ""
      style = "bg:#5b94ab"
      format = '[[ $symbol ($version) ](fg:#d3d3d3 bg:#5b94ab)]($style)'

      [golang]
      symbol = ""
      style = "bg:#5b94ab"
      format = '[[ $symbol ($version) ](fg:#d3d3d3 bg:#5b94ab)]($style)'

      [php]
      symbol = ""
      style = "bg:#5b94ab"
      format = '[[ $symbol ($version) ](fg:#d3d3d3 bg:#5b94ab)]($style)'

      [haskell]
      symbol = ""
      style = "bg:#5b94ab"
      format = '[[ $symbol ($version) ](fg:#d3d3d3 bg:#5b94ab)]($style)'

      [java]
      symbol = ""
      style = "bg:#5b94ab"
      format = '[[ $symbol ($version) ](fg:#d3d3d3 bg:#5b94ab)]($style)'

      [c]
      symbol = ""
      style = "bg:#5b94ab"
      format = '[[ $symbol ($version) ](fg:#d3d3d3 bg:#5b94ab)]($style)'

      [nix_shell]
      symbol = ""
      style = "bg:#5b94ab"
      format = '[[ $symbol ($version) ](fg:#d3d3d3 bg:#5b94ab)]($style)'

      [time]
      disabled = false
      time_format = "%R" # Hour:Minute Format
      style = "bg:#34373e"
      format = '[[  $time ](fg:#c6c6c6 bg:#34373e)]($style)'

    '';
  };
}
