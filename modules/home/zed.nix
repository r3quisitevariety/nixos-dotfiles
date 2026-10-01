{pkgs, ...}: {
  programs.zed-editor = {
    enable = true;
    mutableUserSettings = true;
    mutableUserKeymaps = true;
    mutableUserTasks = false;
    extensions = [
      "nix"
      "typst"
      "discord-presence"
    ];
    extraPackages = with pkgs; [
      nixd
      alejandra
      zed-discord-presence
    ];

    # this doesnt actually work; nix rebuild fails; keeping here for sake of memory
    #userKeymaps = {
    #  bindings = {
    #    "space-f-g" = "text_finder::Toggle";
    #    "space-f-f" = "file_finder::Toggle";
    #    "ctrl-space" = "terminal_panel::Toggle";
    #    "space-e" = "project_panel::ToggleFocus";
    #    "space-l-g" = "git_panel::ToggleFocus";
    #  };
    #};

    userSettings = {
      "cursor_animation" = {enabled = true;};
      "format_on_save" = "on";
      vim = {
        "vim_mode" = true;
        "toggle_relative_line_numbers" = true;
      };

      "project_panel" = {"dock" = "left";};
      "git_panel" = {"dock" = "right";};
      "agent" = {"dock" = "right";};

      "telemetry" = {
        "diagnostics" = false;
        "metrics" = false;
      };

      "lsp" = {
        "discord_presence" = {
          "initialization_options" = {
            "application_id" = "1263505205522337886";
            "base_icons_url" = "https://raw.githubusercontent.com/xhyrom/zed-discord-presence/main/assets/icons";
          };
        };
      };

      languages = {
        "Nix" = {
          language_servers = ["nixd"];
          formatter.external = {
            command = "${pkgs.alejandra}/bin/alejandra";
            arguments = ["--quiet" "--"];
          };
        };
      };
    };
  };
}
