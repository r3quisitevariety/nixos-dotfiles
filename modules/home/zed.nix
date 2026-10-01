{pkgs, ...}: {
  programs.zed-editor = {
    enable = true;
    mutableUserSettings = true;
    mutableUserKeymaps = false;
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
      "format_on_save" = "on";
      "vim_mode" = true;

      "telemetry" = {
        "diagnostics" = false;
        "metrics" = false;
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
