{
  pkgs,
  config,
  inputs,
  user,
  ...
}: {
  imports = [
    ./syncthing.nix
    ../../modules/home/neovim.nix
    ../../modules/home/cli.nix
    ../../modules/home/yt-music-dlp.nix
    ../../modules/nixos/fish/fish.nix
    ../../modules/home/herdr.nix
  ];
  programs.ssh = {
    enableDefaultConfig = false;
    enable = true;
    settings."github.com" = {
      HostName = "github.com";
      User = "git";
      IdentityFile = "/run/nix-secrets/secrets/ssh-key";
      IdentitiesOnly = true;
    };
    settings."nitro5" = {
      HostName = "nitro5";
      User = user;
      IdentityFile = "/run/nix-secrets/secrets/ssh-key";
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
}
