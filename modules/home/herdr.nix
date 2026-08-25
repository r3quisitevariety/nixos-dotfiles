{pkgs, ...}:
# credits to https://madflex.de/trying-herdr-instead-of-tmux/ for the script
let
  herdr-move-tab = pkgs.writeShellScriptBin "herdr-move-tab" ''
    [ -n "$HERDR_ACTIVE_PANE_ID" ] || { echo "no active pane" >&2; sleep 2; exit 1; }

    ws=$(${pkgs.herdr}/bin/herdr workspace list \
      | ${pkgs.jq}/bin/jq -r '.result.workspaces[] | "\(.workspace_id)\t\(.label // .workspace_id)"' \
      | ${pkgs.fzf}/bin/fzf --prompt="move tab to workspace > " --with-nth=2 --delimiter='\t' \
      | cut -f1)
    [ -n "$ws" ] || exit 0

    # herdr refuses to move a pane out of a zoomed tab, so un-zoom it first.
    ${pkgs.herdr}/bin/herdr pane zoom "$HERDR_ACTIVE_PANE_ID" --off >/dev/null 2>&1
    ${pkgs.herdr}/bin/herdr pane move "$HERDR_ACTIVE_PANE_ID" --new-tab --workspace "$ws" --focus
  '';
in {
  home.packages = [herdr-move-tab];

  programs.herdr = {
    enable = true;
    settings = {
      onboarding = false;

      terminal = {
        default_shell = "fish";
        shell_mode = "login";
        new_cwd = "follow";
      };

      theme = {
        name = "catppuccin";
        auto_switch = true;
        light_name = "catppuccin-latte";
        dark_name = "catppuccin";
      };

      ui = {
        sidebar_width = 32;
        sidebar_start_collapsed = true;
        #agent_panel_sort = "priority";
        tab_bar_position = "bottom";
        mouse_capture = true;
        copy_on_select = true;
        show_agent_labels_on_pane_borders = true;
        confirm_close = true;

        # notifies you when an agent needs attendance
        toast = {
          delivery = "herdr";
          delay_seconds = 1;
          herdr.position = "bottom-right";
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
        # normally in tmux i use this for resizing but herdr has prefix + r
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
        goto = "prefix+w";

        # zoom / layout / session
        zoom = "prefix+z";
        copy_mode = "prefix+[";
        toggle_sidebar = "prefix+e";
        reload_config = "prefix+shift+r";
        detach = "prefix+d";

        # move the focused tab to another workspace via an fzf picker
        # in tmux its normally prefix + ! but it's less idiomatic here
        command = [
          {
            key = "prefix+m";
            type = "pane";
            command = "${herdr-move-tab}/bin/herdr-move-tab";
            description = "move tab to workspace";
          }
        ];
      };

      session = {
        resume_agents_on_restore = true;
      };
    };
  };
}
