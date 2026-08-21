{copyparty, ...}: {
  networking.firewall.allowedTCPPorts = [3923];

  # Keep local filesystem access separate from Copyparty's account ACLs.
  # The service module owns the volume root, so grant onoruu access without
  # changing that ownership and make new entries inherit both users' access.
  systemd.tmpfiles.rules = [
    "a+ /srv/copyparty/zx - - - - u:onoruu:rwx"
    "a+ /srv/copyparty/zx - - - - d:u:onoruu:rwx,d:u:copyparty:rwx"
  ];

  nixpkgs.overlays = [copyparty.overlays.default];
  services.copyparty = {
    enable = true;
    # define a containerized user called "copyparty"
    user = "copyparty";
    group = "copyparty";

    settings = {
      i = "0.0.0.0";
      p = [3923];
      no-reload = true;

      # Search/index files and enable upload undo.
      e2dsa = true;
      # Index music metadata such as artist, album, title, BPM, etc.
      e2ts = true;
      # Show dotfiles in search results.
      dotsrch = true;
    };

    accounts = {
      # zx = onoruu
      # just declared like this so i can ssh into copyparty and use coreutils
      # i have some ai slop above for this lol (sorry not sorry)
      onoruu.passwordFile = "/run/nix-secrets/secrets/copyparty-zx";
      smarties.passwordFile = "/run/nix-secrets/secrets/copyparty-smarties";
    };

    volumes = {
      "/zx" = {
        path = "/srv/copyparty/zx";
        access = {
          rwmda = ["onoruu"];
        };
        flags = {
          scan = 60;
        };
      };

      "/smarties" = {
        path = "/srv/copyparty/smarties";
        access = {
          rwdm = ["smarties"];
        };
        flags = {
          scan = 60;
        };
      };
    };
  };
}
