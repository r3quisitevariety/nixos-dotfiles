{inputs, ...}: {
  # home-manager
  imports = [inputs.umbriel.homeModules.default];
  programs.umbriel = {
    enable = true;
    settings = {
      general.autostart = ["noctalia"];
      layout.gap = 5;
      input.keyboard.layout = "us";
      keybinds = {
        "Mod+Q" = "spawn:kitty";
        "Mod+C" = "window-close";
        "Mod+D" = "spawn:noctalia msg panel-toggle launcher";
      };
    };
  };
}
