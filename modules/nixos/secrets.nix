{inputs, ...}: {
  imports = [
    inputs.nix-secrets.nixosModules.default
  ];

  security.nix-secrets = {
    enable = true;
    storage = ../../secrets;
    identityPaths = [
      "/home/nix/.config/age/keys.txt"
    ];
    recipientAliases = {
      master = "age13ndha26pyk8jnhml5p7skurcxzwpf2zh3jj5lj2ru3n36dadhvhseat6cg";
    };
    secrets = {
      # recipients receive the age key to unlock their respective secrets
      # ssh key
      ssh-key = {
        recipients = ["master"];
        owner = "nix";
        group = "users";
        mode = "0600";
      };

      opencode = {
        recipients = ["master"];
        owner = "nix";
        group = "users";
        mode = "0600";
      };

      tailscale = {
        recipients = ["master"];
        owner = "nix";
        group = "users";
        mode = "0600";
      };
      freshrss = {
        recipients = ["master"];
        owner = "nix";
        group = "users";
        mode = "0600";
      };
    };
  };
}
