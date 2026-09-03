{inputs, ...}: {
  # home-manager
  imports = [inputs.umbriel.homeModules.default];

  programs.umbriel = {
    enable = true;
    settings = {
      window_rule = [
        {
          match.app_id = "^(kitty|dev\\.noctalia\\.Noctalia)$";
          blur = true;
        }
      ];

      output = {
        "eDP-1" = {
          enabled = true;
          mode = "1920x1080@144.000";
          position = [
            0
            0
          ];
          scale = 1.0;
          vrr = "always";
          #workspaces = 10;
          tearing = true;
        };
        "HDMI-A-1" = {
          mode = "1920x1080@144.000";
          position = [
            0
            0
          ];
          scale = 1.0;
          vrr = "always";
          # enforces static workspaces
          #workspaces = 10;
          tearing = true;
        };
      };

      general = {
        show_cheatsheet = false;
        xwayland = true;
        autostart = [
          "noctalia"
          "vellum"
          "kitty --single-instance --start-as=hidden tail -f /dev/null"
          "udiskie -a -s --file-manager nautilus"
        ];
      };
      layout.gap = 5;
      input = {
        keyboard.layout = "us";
        touchpad.natural_scroll = true;
      };

      # idk what this actually does lol
      workspaces = {
        back_and_forth = true;
      };

      keybinds = {
        # niceties
        "Mod+A" = "spawn:vellum toggle";
        "Mod+Shift+S" = "spawn:noctalia msg screenshot-region";

        # main
        "Mod+Q" = "spawn:kitty";
        "Mod+C" = "window-close";
        "Mod+D" = "spawn:noctalia msg panel-toggle launcher";

        # meta
        "Mod+Tab" = "overview-toggle";
        "Mod+M" = "session-quit";

        # files
        "Mod+E" = "spawn:nautilus";

        # window management
        "Mod+F" = "window-toggle-maximize";
        "Mod+Shift+F" = "window-toggle-fullscreen";
        "Mod+R" = "window-cycle-width";
        "Mod+V" = "window-toggle-floating";

        # vim. EVERYWHERE
        "Mod+H" = "window-focus-left";
        "Mod+J" = "workspace-next";
        "Mod+K" = "workspace-previous";
        "Mod+L" = "window-focus-right";

        "Mod+Shift+H" = "window-modify-width:-0.1";
        "Mod+Shift+L" = "window-modify-width:0.1";
        "Mod+Shift+K" = "window-modify-height:0.1";
        "Mod+Shift+J" = "window-modify-height:-0.1";

        "Mod+Ctrl+H" = "column-move-left";
        "Mod+Ctrl+K" = "window-move-or-workspace-up";
        "Mod+Ctrl+J" = "window-move-or-workspace-down";
        "Mod+Ctrl+L" = "column-move-right";

        # workspaces
        "Mod+1" = "workspace-switch:1";
        "Mod+2" = "workspace-switch:2";
        "Mod+3" = "workspace-switch:3";
        "Mod+4" = "workspace-switch:4";
        "Mod+5" = "workspace-switch:5";
        "Mod+6" = "workspace-switch:6";
        "Mod+7" = "workspace-switch:7";
        "Mod+8" = "workspace-switch:8";
        "Mod+9" = "workspace-switch:9";
        "Mod+0" = "workspace-switch:10";

        "Mod+Shift+1" = "window-move-to-workspace:1";
        "Mod+Shift+2" = "window-move-to-workspace:2";
        "Mod+Shift+3" = "window-move-to-workspace:3";
        "Mod+Shift+4" = "window-move-to-workspace:4";
        "Mod+Shift+5" = "window-move-to-workspace:5";
        "Mod+Shift+6" = "window-move-to-workspace:6";
        "Mod+Shift+7" = "window-move-to-workspace:7";
        "Mod+Shift+8" = "window-move-to-workspace:8";
        "Mod+Shift+9" = "window-move-to-workspace:9";
        "Mod+Shift+0" = "window-move-to-workspace:10";

        # workspace scroll stuff
        "Mod+Shift+WheelUp" = "window-focus-left";
        "Mod+Shift+WheelDown" = "window-focus-right";
        "Mod+WheelUp" = "window-focus-up";
        "Mod+WheelDown" = "window-focus-down";
      };

      appearance = {
        corner_radius = 12;
        border_focused = "#8aadf4cc";
        border_unfocused = "#c0c6dc33";
        blur = {
          enabled = true;
          optimized = false;
          radius = 12;
          noise = 0.0;
          contrast = 1.25;
          saturation = 1.0;
        };
        shadow = {
          offset_x = 0;
          offset_y = 0;
          color = "#363a4fff";
        };
      };

      layout = {
        scrolling = {
          default_width_fraction = 0.5;
          center_underfull_strip = false;
          expand_single_column = true;
        };
      };

      animation = {
        windows_in = {
          enabled = true;
          duration_ms = 250;
          curve = "easeout";
          style = "popin";
          scale = 0.6;
        };

        windows_out = {
          enabled = true;
          duration_ms = 250;
          curve = "easeout";
          style = "fade";
        };

        windows_move = {
          curve = "snappy";
        };

        workspaces = {
          enabled = true;
          duration_ms = 250;
          curve = "snappy";
        };

        scratchpad = {
          enabled = true;
          duration_ms = 250;
          curve = "easeout";
          dim = 0.2;
        };

        border = {
          enabled = true;
          duration_ms = 250;
          curve = "easeout";
        };
      };
      environment = {
        XCURSOR_THEME = "Bibata-Modern-Ice";
        XCURSOR_SIZE = "16";
        QT_QPA_PLATFORMTHEME = "qt6ct";
      };
    };
  };
}
