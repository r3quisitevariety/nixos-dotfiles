{copyparty, ...}: {
  networking.firewall.allowedTCPPorts = [3923];
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
      zx.passwordFile = "/run/nix-secrets/secrets/copyparty-zx";
      smarties.passwordFile = "/run/nix-secrets/secrets/copyparty-smarties";
    };

    volumes = {
      "/zx" = {
        path = "/srv/copyparty/zx";
        access = {
          rwmda = ["zx"];
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
