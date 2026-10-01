{pkgs, ...}: {
  programs.zed-editor = {
    enable = true;
    mutableUserSettings = true;
    mutableUserKeymaps = true;
    mutableUserTasks = false;
    extensions = [
      "nix"
      "typst"
    ];
    extraPackages = with pkgs; [
      nixd
      alejandra
    ];
    userSettings = {
      "cursor_animation" = {enabled = true;};
      "format_on_save" = "on";
      vim = {
        "vim_mode" = true;
        "toggle_relative_line_numbers" = true;
      };

      "telemetry" = {
        "diagnostics" = false;
        "metrics" = false;
      };

      userKeymaps = {
        bindings = {
          # this doesnt actually work it's just here for show and so i can remember lol
          "space-f-g" = "text_finder::Toggle";
          "space-f-f" = "file_finder::Toggle";
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
