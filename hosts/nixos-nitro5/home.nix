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

  nixpkgs.config.allowUnfree = true;

  services.syncthing = {
    enable = true;
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
