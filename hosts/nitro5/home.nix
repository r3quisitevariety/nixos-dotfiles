{
  pkgs,
  config,
  inputs,
  user,
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
      User = "onoruu";
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

  home.username = user;
  home.homeDirectory = "/home/${user}";
  home.stateVersion = "25.11";

  home.file.".config/hypr/hyprland.lua" = {
    source = ../../normie-dots/hyprland.lua;
    force = true;
  };

  home.file.".config/foot/foot.ini" = {
    source = ../../normie-dots/foot.ini;
    force = true;
  };

  home.file.".config/niri/config.kdl".source =
    config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/nixos-dotfiles/normie-dots/config.kdl";

  home.file.".local/state/noctalia/settings.toml".source =
    config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/nixos-dotfiles/normie-dots/settings.toml";

  # redundant,already declared in configuration.nix
  #nixpkgs.config.allowUnfree = true;

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
      browser = "zen-beta.desktop";
      textEditor = "neovim.desktop";
      chromium = "google-chrome.desktop";
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
    ./syncthing.nix
    ../../modules/home/zedlias.nix
    ../../modules/home/neovim.nix
    ../../modules/home/shell.nix
    ../../modules/home/music.nix
    ../../modules/home/zen.nix
    ../../modules/home/discord.nix
    ../../modules/home/yt-music-dlp.nix
    ../../modules/home/kitty.nix
    ../../modules/nixos/fish/fish.nix
    #../../modules/vr.nix
    #../../modules/obs.nix
    #../../modules/substituters.nix
    #../../modules/noctalia-greeter.nix
    inputs.vellum.homeModules.default
  ];

  services.vellum.enable = true;
}
