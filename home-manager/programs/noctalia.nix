{ config, lib, pkgs, ... }:

{
  programs.noctalia-shell = {
    enable = true;
    
    settings = {
      wallpaper = {
        enabled = true;
        overviewEnabled = false;
        directory = "~/Pictures/Wallpapers";
        recursiveSearch = false;
        setWallpaperOnAllMonitors = true;
        defaultWallpaper = "~/Pictures/Wallpapers/highland_cattle.jpg"; 
      };

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
      sessionMenu = {
        enableCountdown = true;
        countdownDuration = 10000;
        position = "center";
        showHeader = true;
        showKeybinds = true;
        largeButtonsStyle = false;
        # largeButtonsLayout = "single-row";
        powerOptions = [
          {
            action = "lock";
            enabled = true;
            keybind = "1";
          }
          {
            action = "suspend";
            enabled = true;
            keybind = "2";
          }
          # {
          #   action = "hibernate";
          #   enabled = true;
          #   keybind = "3";
          # }
          {
            action = "reboot";
            enabled = true;
            keybind = "3";
          }
          {
            action = "logout";
            enabled = true;
            keybind = "4";
          }
          {
            action = "shutdown";
            enabled = true;
            keybind = "5";
          }
          # {
          #   action = "rebootToUefi";
          #   enabled = true;
          #   keybind = "7";
          # }
        ];
      };

      notifications = {
        enabled = true;
        density = "default";
        monitors = [ ];
        location = "top_right";
        overlayLayer = true;
        backgroundOpacity = 1;
        respectExpireTimeout = false;
        lowUrgencyDuration = 3;
        normalUrgencyDuration = 3;
        criticalUrgencyDuration = 8;
        clearDismissed = true;
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
        terminalCommand = "ghostty -e";
        customLaunchPrefixEnabled = false;
        customLaunchPrefix = "";
      };
      colorSchemes = {
        useWallpaperColors = false;
        predefinedScheme = "Wilmersdorf";
        darkMode = true;
        schedulingMode = "off";
        manualSunrise = "06:30";
        manualSunset = "18:30";
        generationMethod = "tonal-spot";
        monitorForColors = "";
        syncGsettings = true;
      };
      # idle = {
      #     enabled = false;
      #     screenOffTimeout = 600;
      #     lockTimeout = 660;
      #     suspendTimeout = 1800;
      #     fadeDuration = 5;
      #     screenOffCommand = "";
      #     lockCommand = "";
      #     suspendCommand = "";
      #     resumeScreenOffCommand = "";
      #     resumeLockCommand = "";
      #     resumeSuspendCommand = "";
      #     customCommands = "[]";
      #   };

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
        # latitude = 41.979401;
        # longitude = 2.821426;
      };
    };
  };
}
