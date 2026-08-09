{
  pkgs,
  config,
  ...
}: {
  programs.ssh = {
    enableDefaultConfig = false;
    enable = true;

    # "settings.<name>" replaces ~/.ssh/config
    settings."github.com" = {
      HostName = "github.com";
      User = "git";
      IdentityFile = "/run/nix-secrets/secrets/ssh-key";
      IdentitiesOnly = true;
    };
    settings."inspiron" = {
      HostName = "inspiron";
      User = "black";
      # tells ssh WHICH private key to use
      # server MUST have matching public key in its authorized_keys for passwordless to work
      IdentityFile = "/run/nix-secrets/secrets/ssh-key";
      # allows ONLY explicitly configured keys instead of mutable state like ~/.ssh/id_ed25519
      IdentitiesOnly = true;
    };
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "r3quisitevariety";
        email = "x3roo@proton.me";
      };
    };
  };

  home.username = "nix";
  home.homeDirectory = "/home/nix";
  home.stateVersion = "25.11";

  home.file.".config/hypr/hyprland.lua" = {
    source = ../../normie-dots/hyprland.lua;
    force = true;
  };

  home.file.".config/foot/foot.ini" = {
    source = ../../normie-dots/foot.ini;
    force = true;
  };

  home.file.".local/state/noctalia/settings.toml".source =
    config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/nixos-dotfiles/normie-dots/settings.toml";

  # redundant,already declared in configuration.nix
  #nixpkgs.config.allowUnfree = true;

  services.syncthing = {
    enable = true;
    #    overrideDevices = false; # done imperatively like a normie
    #    overrideFolders = false;
    #    settings = {
    #      # declared folders require *everything* is declared, including shared devices, otherwise it will reset on each rebuild, even with overrides disabled.
    #      folders = {
    #        # new obsidian vault, will merge into one once done migrating
    #        masterplan = {
    #          id = "mg7tu-y2qmx";
    #          name = "nix on nitro 5";
    #          enable = true;
    #          path = "~/Documents/masterplan";
    #          type = "sendreceive";
    #        };
    #        obsidian = {
    #          id = "lmski-53ald";
    #          name = "nix on nitro 5";
    #          enable = true;
    #          path = "~/Documents/obsidian";
    #          type = "sendreceive";
    #        };
    #        music = {
    #          id = "gds2p-nvu34"; # same on all devices
    #          name = "nix on nitro 5";
    #          enable = true;
    #          path = "~/Music";
    #          type = "sendreceive";
    #        };
    #        wallpapers = {
    #          id = "a27nj-kwhuv";
    #          name = "nix on nitro 5"; # why is this redundant?
    #          enable = true;
    #          path = "~/Pictures/wallpapers";
    #          type = "sendreceive";
    #        };
    #      };
    #      # requires tailscale to be up
    #      devices = {
    #        inspiron = {
    #          addresses = [
    #            "tcp://inspiron:51820"
    #          ];
    #          id = "2YX5YSA-223OINV-H3R34DR-3BVTSTZ-AHXUAZX-W4LQARI-Z5V5WGE-R3WBMAS";
    #        };
    #
    #        pixel-8-pro = {
    #          addresses = [
    #            "tcp://pixel-8-pro:51820"
    #          ];
    #          id = "QVJASTB-JBK7QRK-W2ZRNKP-6G66XQM-7JVRJ5B-OHN57XC-IEM3VWM-QNHR6AV";
    #        };
    #      };
    #    };
  };

  home.packages = [pkgs.hyprcursor];
  home.pointerCursor = {
    enable = true;
    package = pkgs.bibata-cursors;
    #name = "Bibata-Modern-Classic";

    name = "Bibata-Modern-Ice";
    #package = pkgs.catppuccin-cursors;
    #name = "catppuccin-frappe-blue-cursors";
    size = 16;
    gtk.enable = true;
    x11.enable = true;
    hyprcursor.enable = true;
    hyprcursor.size = 16;
  };

  # thanks elias
  xdg.mimeApps = {
    enable = true;
    defaultApplications = let
      imageViewer = "imv.desktop";
      videoViewer = "mpv.desktop";
      audioViewer = "mpv.desktop";
      fileViewer = "org.gnome.Nautilus.desktop";
      browser = "firefox.desktop";
      textEditor = "codium.desktop";
      chromium = "chromium.desktop";
    in {
      "image/jpeg" = imageViewer;
      "image/png" = imageViewer;
      "image/gif" = browser;
      "image/webp" = imageViewer;
      "image/heif" = imageViewer;
      "text/plain" = textEditor;
      "text/css" = textEditor;
      "application/x-shellscript" = textEditor;
      "application/x-zerosize" = textEditor;
      "text/html" = browser;
      "x-scheme-handler/http" = browser;
      "x-scheme-handler/https" = browser;
      "application/pdf" = browser;
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = chromium;
      "audio/mpeg" = audioViewer;
      "inode/directory" = fileViewer;
      "video/mp4" = videoViewer;
      "video/x-matroska" = videoViewer;
      "video/webm" = videoViewer;
      "video/ogg" = videoViewer;
      "video/quicktime" = videoViewer;
      "video/x-flv" = videoViewer;
      "video/x-msvideo" = videoViewer;
      "video/x-ms-wmv" = videoViewer;
      "video/mpeg" = videoViewer;
      "text/x-chdr" = textEditor;
      "text/x-csrc" = textEditor;
      "text/x-c++hdr" = textEditor;
      "text/x-c++src" = textEditor;
    };
  };

  imports = [
    # TODO i commented these out because i have yet to resolve hostname hardcoding for modules
    ../../modules/home/neovim.nix
    ../../modules/home/shell.nix
    ../../modules/home/music.nix
    ../../modules/home/zen.nix
    ../../modules/home/discord.nix
    ../../modules/home/yt-music-dlp.nix
    #../../modules/vr.nix
    #../../modules/obs.nix
    #../../modules/substituters.nix
    #../../modules/noctalia-greeter.nix
  ];
}
