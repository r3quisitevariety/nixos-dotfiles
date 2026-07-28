{
  pkgs,
  config,
  ...
}: {
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
    "${config.home.homeDirectory}/nixos-dotfiles-2.0/normie-dots/settings.toml";

  # redundant,already declared in configuration.nix
  #nixpkgs.config.allowUnfree = true;

  services.syncthing = {
    enable = true;
  };

  home.packages = [pkgs.hyprcursor];
  home.pointerCursor = {
    enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 20;
    gtk.enable = true;
    x11.enable = true;
    hyprcursor.enable = true;
    hyprcursor.size = 16;
  };

  imports = [
    # TODO i commented these out because i have yet to resolve hostname hardcoding for modules
    ../../modules/home/neovim.nix
    ../../modules/home/shell.nix
    ../../modules/home/music.nix
    ../../modules/home/zen.nix
    #../../modules/vr.nix
    #../../modules/obs.nix
    #../../modules/substituters.nix
    #../../modules/noctalia-greeter.nix
  ];
}
