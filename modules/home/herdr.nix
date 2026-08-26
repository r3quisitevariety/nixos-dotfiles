{pkgs, ...}:
# credits to https://madflex.de/trying-herdr-instead-of-tmux/ for the script
let
  # break the focused pane out into a new tab in the SAME workspace (no picker)
  herdr-break-pane = pkgs.writeShellScriptBin "herdr-break-pane" ''
    [ -n "$HERDR_ACTIVE_PANE_ID" ] || { echo "no active pane" >&2; sleep 2; exit 1; }
    [ -n "$HERDR_ACTIVE_WORKSPACE_ID" ] || { echo "no active workspace" >&2; exit 1; }
    ${pkgs.herdr}/bin/herdr pane zoom "$HERDR_ACTIVE_PANE_ID" --off >/dev/null 2>&1
    ${pkgs.herdr}/bin/herdr pane move "$HERDR_ACTIVE_PANE_ID" --new-tab --workspace "$HERDR_ACTIVE_WORKSPACE_ID" --focus
  '';

  # pick another pane from this workspace and move it into the current tab
  herdr-pull-pane = pkgs.writeShellScriptBin "herdr-pull-pane" ''
    cur_pane="$HERDR_ACTIVE_PANE_ID"
    cur_workspace="$HERDR_ACTIVE_WORKSPACE_ID"
    cur_tab="$HERDR_ACTIVE_TAB_ID"
    [ -n "$cur_pane" ] || { echo "no active pane" >&2; sleep 2; exit 1; }
    [ -n "$cur_workspace" ] || { echo "no active workspace" >&2; sleep 2; exit 1; }
    [ -n "$cur_tab" ] || { echo "no active tab" >&2; sleep 2; exit 1; }

    pane=$(${pkgs.herdr}/bin/herdr pane list --workspace "$cur_workspace" \
      | ${pkgs.jq}/bin/jq -r --arg cur "$cur_pane" '.result.panes[]? | select(.pane_id != $cur) | "\(.pane_id)\t\(.label // .agent // .pane_id)"' \
      | ${pkgs.fzf}/bin/fzf --prompt="pull pane into current tab > " --with-nth=2 --delimiter='\t' \
      | cut -f1)
    [ -n "$pane" ] || exit 0

    # herdr refuses to move a pane out of a zoomed tab, so un-zoom it first.
    ${pkgs.herdr}/bin/herdr pane zoom "$pane" --off >/dev/null 2>&1
    ${pkgs.herdr}/bin/herdr pane move "$pane" --tab "$cur_tab" --split right --focus
  '';
in {
  home.packages = [herdr-break-pane herdr-pull-pane];

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
        #sidebar_width = 32;
        prompt_new_tab_name = false;
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
        close_pane = "prefix+x";
        close_tab = "prefix+ampersand";
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
        zoom = "prefix+f";
        copy_mode = "prefix+[";
        toggle_sidebar = "prefix+e";
        reload_config = "prefix+shift+r";
        detach = "prefix+d";

        # move panes between tabs
        command = [
          {
            key = "prefix+m";
            type = "shell";
            command = "${herdr-break-pane}/bin/herdr-break-pane";
            description = "break pane to new tab";
          }
          {
            key = "prefix+shift+m";
            type = "popup";
            command = "${herdr-pull-pane}/bin/herdr-pull-pane";
            description = "pull pane into current tab";
            width = "80%";
            height = "80%";
          }
        ];
      };

      session = {
        resume_agents_on_restore = true;
      };
    };
  };
}
