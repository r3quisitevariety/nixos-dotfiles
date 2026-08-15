{
  pkgs,
  config,
  inputs,
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
      User = "nix";
      # tells ssh WHICH private key to use
      # server MUST have matching public key in its authorized_keys for passwordless to work
      # authorized_keys will be handled imperatively.
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

  home.username = "onoruu";
  home.homeDirectory = "/home/onoruu";
  home.stateVersion = "25.11";

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

  imports = [
    # TODO i commented these out because i have yet to resolve hostname hardcoding for modules
    ../../modules/home/neovim.nix
    ../../modules/home/shell.nix
    ../../modules/nixos/zsh
    #../../modules/home/music.nix
    #../../modules/home/zen.nix
    #../../modules/home/discord.nix
    ../../modules/home/yt-music-dlp.nix
    #../../modules/vr.nix
    #../../modules/obs.nix
    #../../modules/substituters.nix
    #../../modules/noctalia-greeter.nix
    #inputs.vellum.homeModules.default
  ];
}
