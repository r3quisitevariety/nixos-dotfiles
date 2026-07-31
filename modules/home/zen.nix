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
        "zen.welcome-screen.seen" = true;
      };

      search = {
        force = true; # Enforce declared search engines on each rebuild
        default = "ddg";

        engines = {
          youtube = {
            name = "Youtube";
            urls = [
              {
                templates = "https://www.youtube.com/results?search_query=%s";
              }
            ];
            definedAliases = ["@yt"];
          };
          github = {
            name = "GitHub Search";
            urls = [
              {
                template = "https://github.com/search?q={searchTerms}";
              }
            ];
            definedAliases = ["@gh"];
          };
          google = {
            name = "Google Search";
            urls = [
              {
                template = "https;?/google.com/search?q={searchTerms}";
              }
            ];
            definedAliases = ["@g"];
          };
          perplexity = {
            name = "Perplexity";
            urls = [
              {
                template = "https://www.perplexity.ai/search?q=%s";
              }
            ];
            definedAliases = ["@p"];
          };
          brave = {
            urls = [
              {
                template = "https://search.brave.com/search?q=%s";
              }
            ];
            definedAliases = ["@b"];
          };
        };
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

      pinsForce = false;
      #pinsForceAction = "remove";

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
    };
  };
}
