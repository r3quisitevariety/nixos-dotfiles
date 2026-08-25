{...}: {
  programs.herdr = {
    enable = true;
    settings = {
      onboarding = false;
      terminal = {
        default_shell = "fish";
        shell_mode = "login";
        new_cwd = "follow";
      };

      ui = {
        sidebar_width = 32;
        sidebar_start_collapsed = true;
        tab_bar_position = "bottom";
        mouse_capture = true;
        copy_on_select = true;
        show_agent_labels_on_pane_borders = true;
        confirm_close = true;

        # notifies you when an agent needs attendance
        toast = {
          delivery = "herdr";
          delay_seconds = 1;
          herdr.position = "top-right";
        };

        sound.enabled = false;
      };

      # replace herdr's defaults with tmux-style binds
      keys = {
        prefix = "ctrl+b";

        # navigation
        focus_pane_left = "prefix+h";
        focus_pane_down = "prefix+j";
        focus_pane_up = "prefix+k";
        focus_pane_right = "prefix+l";

        # swap panes
        swap_pane_left = "prefix+shift+h";
        swap_pane_down = "prefix+shift+j";
        swap_pane_up = "prefix+shift+k";
        swap_pane_right = "prefix+shift+l";

        split_vertical = "prefix+%";
        split_horizontal = "prefix+\"";

        # tabs
        new_tab = "prefix+c";
        close_tab = "prefix+x";
        next_tab = "prefix+n";
        previous_tab = "prefix+p";
        rename_tab = "prefix+,";
        switch_tab = "prefix+1..9";

        # workspaces (same binds as tabs but with added shift)
        new_workspace = "prefix+shift+c";
        close_workspace = "prefix+shift+x";
        next_workspace = "prefix+shift+n";
        previous_workspace = "prefix+shift+p";
        rename_workspace = "prefix+shift+$";
        switch_workspace = "prefix+shift+1..9";

        # zoom / layout / session
        goto = "prefix+w";
        zoom = "prefix+z";
        copy_mode = "prefix+[";
        toggle_sidebar = "prefix+e";
        reload_config = "prefix+shift+r";
        detach = "prefix+d";
      };
      session = {
        resume_agents_on_restore = true;
      };
    };
  };
}
