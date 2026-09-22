{ config, lib, pkgs, ... }:

{
  programs.noctalia = {
    enable = true;
    # v4 "colors" became a v5 custom palette (its palette JSON uses the same
    # Material role names, so your 16 colors drop in untouched). This writes
    # ~/.config/noctalia/palettes/Wilmersdorf.json
    customPalettes.Wilmersdorf = {
      dark = {
        mPrimary = "#90a6db";          # key2 - brighter blue accent
        mOnPrimary = "#18191f";        # bg00
        mSecondary = "#5b94ab";        # str - teal strings
        mOnSecondary = "#18191f";      # bg00
        mTertiary = "#b0a2e7";         # str - magenta accent
        mOnTertiary = "#18191f";       # bg00
        mError = "#e1c1ee";            # warning/magenta - soft pink
        mOnError = "#18191f";          # bg00
        mSurface = "#282b33";          # bg1 - main background
        mOnSurface = "#ababab";        # fg2 - dimmed foreground
        mSurfaceVariant = "#1f2024";   # bg0 - slightly darker surface
        mOnSurfaceVariant = "#6e7899"; # comment
        mOutline = "#41454b";          # bg3 - subtle borders
        mShadow = "#18191f";           # bg00
        mHover = "#34373e";            # bg2 - hover background
        mOnHover = "#d3d3d3";          # fg0
      };
    };

    settings = {
      theme = {
        mode = "dark";
        source = "custom";              # v4 colorSchemes.predefinedScheme/colors
        custom_palette = "Wilmersdorf";
      };

      # v4 wallpaper.* (overviewEnabled and setWallpaperOnAllMonitors have no
      # v5 equivalent - wallpaper covers all outputs in v5)
      wallpaper = {
        enabled = true;
        directory = "~/Pictures/Wallpapers";
        default.path = "~/Pictures/Wallpapers/highland_cattle.jpg";
        automation = { recursive = false; }; # was recursiveSearch
      };

      # v4 general.* + ui.*
      shell = {
        avatar_path = "~/Pictures/icons/lambda_m.png"; # was general.avatarImage
        corner_radius_scale = 1.0;                     # was general.radiusRatio
        font_family = "Inter";                         # was ui.fontDefault
        clipboard_enabled = true;                      # was appLauncher.enableClipboardHistory
        # v4 ui.fontFixed / tooltipsEnabled and customLaunchPrefix dropped;
        # terminalCommand auto-detected from $TERMINAL/Ghostty in v5
      };

      # v4 sessionMenu.* (also floats: shell.panel.session_placement)
      shell.session = {
        show_shortcuts = true;         # was showKeybinds  (largeButtons* -> grid below)
        grid = false;
        actions = [
          { action = "lock";     shortcut = "1"; }
          { action = "suspend";  shortcut = "2"; }
          # v4 didn't enable hibernate / rebootToUefi
          { action = "reboot";   shortcut = "3"; }
          { action = "logout";   shortcut = "4"; }
          { action = "shutdown"; shortcut = "5"; }
        ];
      };

      # v4 notifications.* (density, monitors, per-urgency durations,
      # respectExpireTimeout dropped; clearDismissed inverts to keep_*)
      notification = {
        enable_daemon = true;
        layer = "overlay";             # was overlayLayer
        background_opacity = 1.0;      # was backgroundOpacity
        keep_dismissed_in_history = false; # was clearDismissed
        offset_x = 20;
        offset_y = 8;
      };
      # v4 notifications.location / enableKeyboardLayoutToast
      osd = {
        position = "top_right";
        kinds = { keyboard_layout = true; };
      };

      # v4 brightness.* (brightnessStep dropped in v5)
      brightness = {
        enable_ddcutil = false;        # was enableDdcSupport
        minimum_brightness = 0.05;     # was enforceMinimum
      };

      # v4 appLauncher.* -> shell.launcher
      shell.launcher = {
        sort_by_usage = true;          # was sortByMostUsed
        pinned = [ ];                  # was pinnedExecs
      };

      # v4 idle.* (uncommented) -> [idle.behavior.*]
      # idle = {
      #   pre_action_fade_seconds = 5.0;
      #   behavior."screen-off" = { timeout = 600; action = "screen_off"; enabled = true; };
      #   behavior.lock = { timeout = 660; action = "lock"; enabled = true; };
      # };

      dock = { enabled = false; };

      # v4 bar.* -> [bar.main]; density has no direct equivalent, so
      # thickness/padding/scale approximate the old "compact" density
      bar.main = {
        position = "top";
        capsule = false;               # was showCapsule
        thickness = 30;
        padding = 8;
        widget_spacing = 4;
        font_scale = 0.95;
        start  = [ "control-center" ];   # was ControlCenter
        center = [ "workspaces" ];       # was Workspace (labelMode lost)
        end    = [ "clock" "network" "bluetooth" "tray" ]; # was Clock WiFi Bluetooth Tray
      };

      # per-widget options live under [widget.<name>]
      widget.clock = {
        format = "{:%H:%M %a}";     # was formatHorizontal "HH:mm ddd"
        vertical_format = "{:%H:%M}"; # was formatVertical
        font_family = "monospace";  # was useMonospacedFont
        color = "primary";          # was usePrimaryColor
      };

      # v4 location.* (monthBeforeDay is locale-driven in v5; name -> address)
      location = {
        address = "Girona, Spain";
        # latitude  = 41.979401;  # only needed if auto_locate/address are off
        # longitude = 2.821426;
      };
    };
  };
}