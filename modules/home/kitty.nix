{config, ...}: {
  programs.kitty = {
    enable = true;

    font = {
      name = "Mape Mono NF";
      size = 11;
    };

    settings = {
      enable_audio_bell = false;
      allow_remote_control = "yes";
      listen_on = "unix:/tmp/kitty";
      background_blur = 24;
      background_opacity = "0.8";
      confirm_os_window_close = 0;
      hide_window_decorations = "yes";
      placement_strategy = "top-left";
      cursor_trail = 4;
      cursor_trail_decay = "0.1 0.5";
      cursor_trail_start_threshold = 0;
      resize_debounce_time = "0 0";
      scrollbar = "never";
      window_padding_width = 2;
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
    };

    keybindings = {
      "shift+cmd+backspace" = "change_font_size all 10";
      "shift+cmd+minus" = "change_font_size all -1.0";
      "shift+cmd+plus" = "change_font_size all +1.0";
    };

    extraConfig = ''
      include ${config.xdg.configHome}/kitty/themes/noctalia.conf
    '';
  };
}
