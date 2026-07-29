{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.zen-browser.homeModules.beta
  ];

  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;

    profiles.default = {
      settings = {
        "ui.systemUsesDarkTheme" = 1;
        # Auto-enable extensions installed via HM
        "extensions.autoDisableScopes" = 0;
        "extensions.showRecommendations" = false;
      };

      extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
        bitwarden
        darkreader
        i-dont-care-about-cookies
        vimium
        #unhook
        #libredirect
        #obsidian-web-clippper
      ];

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
      };
      pins.claude = {
        id = "claude";
        url = "https://claude.ai/new";
        isEssential = true;
      };
      pins.nixos-dotfiles = {
        id = "nixos-dotfiles";
        url = "https://github.com/r3quisitevariety/nixos-dotfiles-2.0";
        isEssential = true;
      };
      pins.nix-search = {
        id = "nix-search";
        url = "https://nixsearch.thekoppe.com/";
        isEssential = true;
      };
      pins.hm-options = {
        id = "hm-options";
        url = "https://nix-community.github.io/home-manager/options/home-manager/index.html";
        isEssential = true;
      };
    };
  };
}
