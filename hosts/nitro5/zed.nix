{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    mcp-nixos
    nil
    nixfmt
    alejandra
    pyright
    black
    bash-language-server
    shfmt
    lua-language-server
    stylua
    ripgrep
    fd
  ];

  programs.zed-editor = {
    enable = true;
    mutableUserSettings = false;
    mutableUserKeymaps = false;
    mutableUserTasks = false;
    extensions = [
      "catppuccin"
      "catppuccin-icons"
      "catppuccin-blur"
      "nix"
    ];
    userSettings = {
      "edit_predictions" = {
        "provider" = "none";
      };
      "format_on_save" = "on";
      "base_keymap" = "JetBrains";
      "session" = {
        "trust_all_worktrees" = true;
      };
      "vim_mode" = true;
      "line_height" = "comfortable";
      "project_panel" = {
        "dock" = "left";
        "entry_spacing" = "comfortable";
        "hide_gitignore" = true;
        "default_width" = 200.0;
      };
      "outline_panel" = {
        "dock" = "left";
      };
      "collaboration_panel" = {
        "dock" = "left";
      };
      "git_panel" = {
        "dock" = "left";
      };
      "icon_theme" = "Catppuccin Macchiato";
      "telemetry" = {
        "diagnostics" = false;
        "metrics" = false;
      };
      "theme" = {
        "mode" = "dark";
        "light" = "Catppuccin Latte";
        "dark" = "Catppuccin Macchiato (Blur)";
      };
      "languages" = {
        "YAML" = {
          "format_on_save" = "off";
        };
        "Nix" = {
          "language_servers" = ["nil"];
          "formatter" = {
            "external" = {
              "command" = "alejandra";
              "arguments" = [];
            };
          };
        };
      };
      "minimap" = {
        "show" = "always";
      };
      "lsp" = {
        "nil" = {
          "binary" = {
            "path" = "nil";
          };
        };
      };

      "agent" = {
        "dock" = "right";
      };
      "agent_servers" = {
        "claude-acp" = {
          "type" = "registry";
        };
        "mcp-nixos" = {
          "type" = "registry";
        };
      };
    };
  };
}
