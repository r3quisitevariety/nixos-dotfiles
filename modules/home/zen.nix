{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.zen-browser.homeModules.beta
  ];
  # preservation might solve issues with flake config not applying onto zen.
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

      #search = {
      #  force = false; # Enforce declared search engines on each rebuild
      #  default = "ddg";

      #  engines = {
      #    youtube = {
      #      name = "Youtube";
      #      urls = [
      #        {
      #          templates = "https://www.youtube.com/results?search_query={searchTerms}";
      #        }
      #      ];
      #      definedAliases = ["@yt"];
      #    };
      #    github = {
      #      name = "GitHub Search";
      #      urls = [
      #        {
      #          template = "https://github.com/search?q={searchTerms}";
      #        }
      #      ];
      #      definedAliases = ["@gh"];
      #    };
      #    google = {
      #      name = "Google Search";
      #      urls = [
      #        {
      #          template = "https;?/google.com/search?q={searchTerms}";
      #        }
      #      ];
      #      definedAliases = ["@g"];
      #    };
      #    perplexity = {
      #      name = "Perplexity";
      #      urls = [
      #        {
      #          template = "https://www.perplexity.ai/search?q={searchTerms}";
      #        }
      #      ];
      #      definedAliases = ["@p"];
      #    };
      #    brave = {
      #      urls = [
      #        {
      #          template = "https://search.brave.com/search?q={searchTerms}";
      #        }
      #      ];
      #      definedAliases = ["@b"];
      #    };
      #  };
      #};

      extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
        bitwarden
        darkreader
        i-dont-care-about-cookies
        vimium
        web-clipper-obsidian
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
        url = "https://github.com/r3quisitevariety/nixos-dotfiles";
        isEssential = true;
      };
      pins.nix-search = {
        id = "nix-search";
        url = "https://nixsearch.thekoppe.com/";
        isEssential = true;
      };
      pins.gmail = {
        id = "gmail";
        url = "https://gmail.com";
        isEssential = true;
      };
      pins.immich = {
        id = "immich";
        url = "http://inspiron:2283";
        isEssential = true;
      };
      pins.protonmail = {
        id = "protonmail";
        url = "https://mail.proton.me";
        isEssential = true;
      };
      pins.notion = {
        id = "notion";
        url = "https://app.notion.com";
        isEssential = true;
      };
      pins.opencode-go = {
        id = "opencode-go";
        url = "https://opencode.ai/go";
        isEssential = true;
      };
    };
  };
}
