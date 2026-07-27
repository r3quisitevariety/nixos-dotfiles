{inputs, ...}: {
  imports = [
    inputs.zen-browser.homeModules.beta
  ];

  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;

    profiles.default = {
      settings."ui.systemUsesDarkTheme" = 1;
      pinsForce = true;
      pinsForceAction = "remove";

      keyboardShortcuts = [
        {
          id = "zen-compact-mode-toggle";
          key = "e";
          modifiers.control = true;
        }
      ];

      pins.google-calendar = {
        id = "google-calendar";
        url = "https://calendar.google.com";
        isEssential = true;
        position = 1;
      };
      pins.claude = {
        id = "claude";
        url = "https://claude.ai/new";
        isEssential = true;
        position = 2;
      };
      pins.gemini = {
        id = "gemini";
        url = "https://gemini.google.com/app";
        isEssential = true;
        position = 3;
      };
      pins.nixos-dotfiles = {
        id = "nixos-dotfiles";
        url = "https://github.com/r3quisitevariety/nixos-dotfiles-2.0";
        isEssential = true;
        position = 4;
      };
    };
  };
}
