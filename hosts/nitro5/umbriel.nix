{inputs, ...}: {
  imports = [inputs.umbriel.homeModules.default];
  programs.umbriel = {
    enable = true;
    settings = {
      general = {
        autostart = [
          "kitty --single-instance --start-as=hidden tail -f /dev/null"
          "noctalia"
        ];
        show_cheatsheet = false;
      };

      environment = {
        QT_QPA_PLATFORMTHEME = "qt6ct";
        #GBM_BACKEND = "nvidia-drm";
        #__GLX_VENDOR_LIBRARY_NAME = "nvidia";
        #LIBVA_DRIVER_NAME = "nvidia";
        NVD_BACKEND = "direct";
        XDG_CURRENT_DESKTOP = "umbriel";
        XDG_SESSION_TYPE = "wayland";
        XDG_SESSION_DESKTOP = "umbriel";
      };

      workspaces.back_and_forth = false;

      appearance = {
        prefer_no_csd = true;
        border_width = 0;
        outer_border_width = 0;
        corner_radius = 5;
        animation_ms = 250;
        blur = {
          enabled = true;
          optimized = true;
          passes = 4;
          radius = 3;
          noise = 0.02;
          saturation = 1.5;
        };
        shadow = {
          enabled = true;
          softness = 4;
          offset_x = 0;
          offset_y = 0;
          color = "#1a1a1aee";
        };
      };

      layout = {
        mode = "scrolling";
        gap = 10;
        width_presets = [
          0.33333
          0.5
          0.66667
          1.0
        ];
        scrolling.default_width_fraction = 0.5;
      };

      output = {
        "eDP-1" = {
          enabled = false;
          mode = "1920x1080@144.000";
          position = [
            0
            0
          ];
          scale = 1.0;
          vrr = "always";
        };
        "HDMI-A-1" = {
          mode = "1920x1080@144.000";
          position = [
            0
            0
          ];
          scale = 1.0;
          vrr = "always";
          workspaces = 9;
        };
      };

      input = {
        middle_click_paste = true;
        keyboard.layout = "us";
        touchpad.natural_scroll = true;
        mouse.sensitivity = 1;
        focus.follows_mouse = true;
      };

      window_rule = [
        {
          match.app_id = "^(zen|equibop|discord|vesktop)$";
          default_width = 1.0;
        }
        {
          match.app_id = "^electron$";
          match.title = "Obsidian";
          default_width = 1.0;
        }
      ];

      keybinds = {
        "Mod+A" = "spawn:vellum toggle";
        "Mod+Shift+Slash" = "cheatsheet-toggle";
        "Mod+Tab" = "overview-toggle";
        "Mod+Q" = "spawn:kitty --single-instance";
        "Mod+D" = "spawn:noctalia msg panel-open launcher";
        "Mod+E" = "spawn:nautilus";
        "Mod+C" = "window-close";
        "Mod+F" = "window-toggle-maximize";
        "Mod+Shift+F" = "window-toggle-fullscreen";
        "Mod+V" = "window-toggle-floating";
        "Mod+M" = "session-quit";

        "Mod+H" = "window-focus-left";
        "Mod+Shift+WheelUp" = "window-focus-left";
        "Mod+Shift+WheelDown" = "window-focus-right";
        "Mod+WheelUp" = "window-focus-up";
        "Mod+WheelDown" = "window-focus-down";
        "Mod+K" = "window-focus-up";
        "Mod+J" = "window-focus-down";
        "Mod+L" = "window-focus-right";
        "Mod+Ctrl+H" = "column-move-left";
        "Mod+Ctrl+L" = "column-move-right";

        "Mod+Shift+H" = "window-modify-width:-0.1";
        "Mod+Shift+L" = "window-modify-width:0.1";
        "Mod+Shift+K" = "window-modify-width:-0.1";
        "Mod+Shift+J" = "window-modify-width:0.1";

        "Mod+1" = "workspace-switch:1";
        "Mod+2" = "workspace-switch:2";
        "Mod+3" = "workspace-switch:3";
        "Mod+4" = "workspace-switch:4";
        "Mod+5" = "workspace-switch:5";
        "Mod+6" = "workspace-switch:6";
        "Mod+7" = "workspace-switch:7";
        "Mod+8" = "workspace-switch:8";
        "Mod+9" = "workspace-switch:9";

        "Mod+Shift+1" = "window-move-to-workspace:1";
        "Mod+Shift+2" = "window-move-to-workspace:2";
        "Mod+Shift+3" = "window-move-to-workspace:3";
        "Mod+Shift+4" = "window-move-to-workspace:4";
        "Mod+Shift+5" = "window-move-to-workspace:5";
        "Mod+Shift+6" = "window-move-to-workspace:6";
        "Mod+Shift+7" = "window-move-to-workspace:7";
        "Mod+Shift+8" = "window-move-to-workspace:8";
        "Mod+Shift+9" = "window-move-to-workspace:9";

        "Mod+R" = "window-cycle-width";
        Print = "spawn:noctalia msg screenshot-fullscreen";
        "Ctrl+Print" = "spawn:noctalia msg screenshot-screen";
        "Alt+Print" = "spawn:noctalia msg screenshot-window";
        "Mod+Shift+S" = "spawn:noctalia msg screenshot-region";

        XF86AudioRaiseVolume = "spawn:wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ -l 1.0";
        XF86AudioLowerVolume = "spawn:wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
        XF86AudioMute = "spawn:wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        XF86AudioMicMute = "spawn:wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
        XF86MonBrightnessUp = "spawn:brightnessctl s 10%+";
        XF86MonBrightnessDown = "spawn:brightnessctl s 10%-";
        XF86AudioPlay = "spawn:playerctl play-pause";
        XF86AudioPause = "spawn:playerctl play-pause";
        XF86AudioNext = "spawn:playerctl next";
        XF86AudioPrev = "spawn:playerctl previous";
      };
    };
  };
}
