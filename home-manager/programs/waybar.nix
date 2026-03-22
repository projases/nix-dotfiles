{ config,lib, pkgs, ... }:

{
  programs.waybar = {
    # enable = true;
    package = pkgs.waybar;
    systemd.enable = true;
    settings = {
      mainBar = {
        # exclusive = false;
        passthrough = false;
        layer = "top";
        height = 40;
        margin = "3";
        position = "top";
        modules-left =
          [
            "custom/logo"
            "hyprland/workspaces"
          ];

          modules-center = [
            "cpu"
            "memory"
            "clock"
            "disk"
          ];

          modules-right = [
            # "network"
            "pulseaudio"
            # "battery"
            "tray"
          ];

          "custom/logo" = {
            format = "<span font='20'> </span>"; #
            on-click = "wlogout";
            color = "#a6c1e0";
          };
          disk = {
            interval = 15;
            format = "󰋊 {percentage_used}% ";

          };
          "hyprland/workspaces" = {
            format = "{windows}";
            # format = "<sub>{icon}</sub>\n {name}";
            format-window-separator = " ";
            window-rewrite-default = "󰙀";#
            window-rewrite = {
              "title<.*youtube.*>" = ""; #// Windows whose titles contain "youtube"
              "zen browser"= "";# // Windows whose classes are "firefox"
              "zen browser title<.*github.*>"= "";#// Windows whose class is "firefox" and title contains "github". Note that "class" always comes first.
              "class<chromium>"= "";
              "class<org.gnome.Evince>" = "";
              "kitty" = "";# // Windows that contain "foot" in either class or title. For optimization reasons, it will only match against a title if at least one other window explicitly matches against a title.
              "warp" = "";
              "ghostty" = "";
              "emacs" = "";
              "nautilus" = "";
              "webcord" = "";
              "spotify" = "";
              "jetbrains-idea-ce" = "";
              "vlc" = "󰕼";
            };

            on-click = "activate";
          };
          
          clock = {
            interval = 1;
            format = "{:%d/%m  %H:%M}";
            format-alt = "{:%Y-%m-%d %H:%M: %z}";
            on-click-left = "mode";
            tooltip-format = ''
              <big>{:%Y %B}</big>
              <tt><small>{calendar}</small></tt>'';
          };

          cpu = {
            format = " {usage}%";#
          };
          memory = {
            format = " {}%"; #
            interval = 5;
          };

          pulseaudio = {
            format = "{icon}  {volume}%";
            format-muted = "";
            format-icons = {
              headphone = "󰋋";
              headset = "";
              portable = "";
              default = [
                ""
                ""
                ""
              ];
            };
            on-click = lib.getExe pkgs.pavucontrol;
          };
          # idle_inhibitor = {
          #   format = "{icon}";
          #   format-icons = {
          #     activated = "󰒳";
          #     deactivated = "󰒲";
          #   };
          # };
          # battery = {
          #   bat = "BAT0";
          #   interval = 10;
          #   format-icons = [
          #     "󰁺"
          #     "󰁻"
          #     "󰁼"
          #     "󰁽"
          #     "󰁾"
          #     "󰁿"
          #     "󰂀"
          #     "󰂁"
          #     "󰂂"
          #     "󰁹"
          #   ];
          #   format = "{icon}";
          #   format-charging = "󰂄";#🔋
          #   onclick = "";

          # };

          # network = {
          #   interval = 3;
          #   format-wifi = " ";
          #   format-ethernet = "󰈁 Connected";
          #   format-disconnected = "󰤮";#
          #   tooltip-format = ''
          #     {ifname}
          #     {ipaddr}/{cidr}
          #     Up: {bandwidthUpBits}
          #     Down: {bandwidthDownBits}'';
          # };
          tray = {
            icon-size = 18;
            spacing = 6;
            show-passive-items = true;

          };
      };
    };
  style =
    ''
      * {

      font-family: "Vegur", "Font Awesome 6 Free", "NotoSans Nerd Font";
      font-size: 16px;
      font-weight: bold;
      padding: 0;
      margin: 0 0.4em;
      }

      window#waybar {
      padding: 0;
      border-radius: 0.5em;
      background-color: #0D1017; /*#131721; #282b33;*/
      border: 1px solid #7ebebd;
      opacity: 0.9;
      color: #f5f5f5;
      }
      .modules-left {
      /* margin-left: 250px;*/
      font-size: 20px;
      }
      .modules-right {
      /*margin-right: -0.65em;*/
      }

      #workspaces button {
      color: #f5f5f5;
      padding-left: 0.4em;
      padding-right: 0.5em;
      margin-top: 0.15em;
      margin-bottom: 0.15em;
      }
      #workspaces button.icon{
      font-size: 20px;
      }
      #workspaces button.focused,
      #workspaces button.active {
      background-color: #e1c1ee;
      }

      #clock {
      padding-right: 1em;
      padding-left: 1em;
      border-radius: 0.5em;
      }
      #disk {
      color: #f5f5f5;
      padding: 0px 15px;
      }
      #custom-menu {
      padding-right: 1.5em;
      padding-left: 1em;
      margin-right: 0;
      border-radius: 0.5em;
      }
      #custom-menu.fullscreen {
      }
      #custom-hostname {
      padding-right: 1em;
      padding-left: 1em;
      margin-left: 0;
      border-radius: 0.5em;
      }
      #custom-currentplayer {
      padding-right: 0;
      }
      #tray {
            }
      #custom-gpu, #cpu, #memory {
      margin-left: 0.05em;
      margin-right: 0.55em;
      }
    '';

   };
}
