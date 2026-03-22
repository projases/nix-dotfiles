{ config, lib, pkgs, ... }:

{
  programs.wlogout = {
    enable = true;
    package = pkgs.wlogout;

    layout = [

      {
    label = "lock";
    action = "loginctl lock-session";
    text = "Lock";
    keybind = "l";
}
{
    label = "hibernate";
    action = "systemctl hibernate";
    text = "Hibernate";
    keybind = "h";
}
{
    label = "logout";
    action = "hyprctl dispatch exit";
    text = "Logout";
    keybind = "e";
}
{
    label = "shutdown";
    action = "shutdown";
    text = "Shutdown";
    keybind = "s";
}
{
    label = "suspend";
    action = "systemctl suspend";
    text = "Suspend";
    keybind = "u";
}
{
    label = "reboot";
    action = "reboot";
    text = "Reboot";
    keybind = "r";
}
    ];

    style = ''


        window {
            background-color: rgba(36, 39, 58, 0.9);
        }

        button {
            margin: 8px;
            color: #f5f5f5;
            background-color: #131721; /*#0D1017; #363a4f;*/
            border-style: solid;
            background-repeat: no-repeat;
            background-position: center;
            background-size: 25%;
        }

        button:active,
        button:focus,
        button:hover {
            color: #8bd5ca;
            background-color: #24273a;
            outline-style: none;
        }

        #lock {
            background-image: image(url("/home/pablo/Pictures/icons/lock.svg"));
        }

        #logout {
            background-image: image(url("/home/pablo/Pictures/icons/logout.svg"));
        }

        #suspend {
            background-image: image(url("/home/pablo/Pictures/icons/suspend.svg"));
        }

        #hibernate {
            background-image: image(url("/home/pablo/Pictures/icons/hibernate.svg"));
        }

        #shutdown {
            background-image: image(url("/home/pablo/Pictures/icons/shutdown.svg"));
        }

        #reboot {
            background-image: image(url("/home/pablo/Pictures/icons/reboot.svg"));
        }

    '';
  };
}
