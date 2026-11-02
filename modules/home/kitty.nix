{config, ...}: {
  programs.kitty = {
    enable = true;

    font = {
      name = "Maple Mono NF";
      size = 11;
    };

    settings = {
      enable_audio_bell = false;
      allow_remote_control = "yes";
      text_composition_strategy = "legacy";
      listen_on = "unix:/tmp/kitty";
      background_blur = 24;
      background_opacity = "0.8";
      confirm_os_window_close = 0;
      hide_window_decorations = "yes";
      placement_strategy = "top-left";
      window_padding_width = 10;
      window_padding_height = 10;
      #cursor_trail = 4;
      #cursor_trail_decay = "0.1 0.5";
      #cursor_trail_start_threshold = 0;
      cursor_blink_interval = 0;
      cursor_shape = "beam";
      resize_debounce_time = "0 0";
      scrollbar = "never";
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
    };

    keybindings = {
      "ctrl+shift+backspace" = "change_font_size all 11";
      "ctrl+shift+minus" = "change_font_size all -0.5";
      "ctrl+shift+plus" = "change_font_size all +0.5";
    };

    extraConfig = ''
      include ${config.xdg.configHome}/kitty/themes/noctalia.conf
    '';
  };
}
