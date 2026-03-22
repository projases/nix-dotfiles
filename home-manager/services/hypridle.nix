{ config, lib, pkgs, ... }:

{
  services.hypridle = {
    enable = true;
    package = pkgs.hypridle;
    systemdTarget = "hyprland-session.target";
    settings = {
      general = {
        after_sleep_cmd = "notify-send 'Awake!'";
        ignore_dbus_inhibit = false;
        ignore_systemd_inhibit = false;
       };
      listener = [
        {
          timeout = 200;
          on-timeout = "brightnessctl -s set 10";
          on-resume = "brightnessctl -r";
        }

        {
          timeout = 600;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          timeout = 1605;
          on-timeout = "systemctl suspend";
          on-resume = "hyprctl dispatch dpms on";
        }

      ];
    };
  };
}
