{ config, lib, pkgs, ... }:

{
  programs.noctalia-shell = {
    enable = true;
    colors = {
      mError = "#e1c1ee";          # warning/magenta - soft pink for errors
      mHover = "#34373e";          # bg2 - hover background
      mOnError = "#18191f";        # bg00 - darkest bg for text on error
      mOnHover = "#d3d3d3";        # fg0 - brightest fg for hover states
      mOnPrimary = "#18191f";      # bg00 - darkest bg for text on primary
      mOnSecondary = "#18191f";    # bg00 - darkest bg for text on secondary
      mOnSurface = "#ababab";      # fg2 - dimmed foreground for body text
      mOnSurfaceVariant = "#6e7899"; # comment - for less important text
      mOnTertiary = "#18191f";     # bg00 - darkest bg for text on tertiary
      mOutline = "#41454b";        # bg3 - subtle borders
      mPrimary = "#90a6db";        # key2 - brighter blue accent
      mSecondary = "#5b94ab";      # str - teal strings
      mShadow = "#18191f";         # bg00 - darkest for shadows
      mSurface = "#282b33";        # bg1 - main background
      mSurfaceVariant = "#1f2024"; # bg0 - slightly darker surface
      mTertiary = "#b0a2e7";       # str - magenta accent
    };
    settings = {
      wallpaper = {
        enabled = true;
        overviewEnabled = false;
        directory = "~/Pictures/Wallpapers";
        recursiveSearch = false;
        setWallpaperOnAllMonitors = true;
        defaultWallpaper = "~/Pictures/Wallpapers/highland_cattle.jpg"; 
      };

      notifications = {
        enabled = true;
        monitors = [ ];
        location = "top_right";
        overlayLayer = true;
        backgroundOpacity = 1;
        respectExpireTimeout = false;
        lowUrgencyDuration = 3;
        normalUrgencyDuration = 8;
        criticalUrgencyDuration = 15;
        enableKeyboardLayoutToast = true;
      };

      ui = {
        fontDefault = "Inter";
        fontFixed = "Azeret Mono";
        fontDefaultScale = 1;
        fontFixedScale = 1;
        tooltipsEnabled = true;
      };
      brightness = {
        brightnessStep = 5;
        enforceMinimum = true;
        enableDdcSupport = false;
      };
      appLauncher = {
        enableClipboardHistory = true;
        position = "center";
        pinnedExecs = [ ];
        useApp2Unit = false;
        sortByMostUsed = true;
        terminalCommand = "ghossty -e";
        customLaunchPrefixEnabled = false;
        customLaunchPrefix = "";
      };
      
      dock = {
        enabled = false;
      };

      bar = {
        density = "compact";
        position = "top";
        showCapsule = false;
        widgets = {
          left = [
            {
              id = "ControlCenter";
              useDistroLogo = true;
            }
          ];

          center = [
            {
              hideUnoccupied = false;
              id = "Workspace";
              labelMode = "none";
            }
          ];

          right = [

            {
              formatHorizontal = "HH:mm ddd";
              formatVertical = "HH mm";
              id = "Clock";
              useMonospacedFont = true;
              usePrimaryColor = true;
            }

            {
              id = "WiFi";
            }
            {
              id = "Bluetooth";
            }

            {
              id = "Tray";
            }
          ];
        };
      };
      general = {
        avatarImage = "~/Pictures/icons/lambda_m.png";
        radiusRatio = 1;
      };
      location = {
        monthBeforeDay = true;
        name = "Girona, Spain";
      };
    };
  };
}
