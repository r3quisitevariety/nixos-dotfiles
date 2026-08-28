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

    settings."nitro5" = {
      HostName = "nitro5";
      User = user;
      # tells ssh WHICH private key to use
      # server MUST have matching public key in its authorized_keys for passwordless to work
      # authorized_keys will be handled imperatively.
      # authorized keys are enabled as a nixos module (openssh.authorizedKeys)
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

  imports = [
    ./syncthing.nix
    # TODO i commented these out because i have yet to resolve hostname hardcoding for modules
    ../../modules/home/neovim.nix
    ../../modules/home/shell.nix
    #../../modules/home/music.nix
    #../../modules/home/zen.nix
    #../../modules/home/discord.nix
    ../../modules/home/yt-music-dlp.nix
    ../../modules/nixos/fish/fish.nix
    ../../modules/home/herdr.nix
    #../../modules/vr.nix
    #../../modules/obs.nix
    #../../modules/substituters.nix
    #../../modules/noctalia-greeter.nix
    #inputs.vellum.homeModules.default
  ];
}
