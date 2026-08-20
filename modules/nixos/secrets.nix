{
  inputs,
  user,
  ...
}: {
  # shared secrets across hosts
  # host specific secrets have their own secrets.nix
  # this module is needed to pass the age key to host-specific configurations
  imports = [
    inputs.nix-secrets.nixosModules.default
  ];

  security.nix-secrets = {
    enable = true;
    storage = ../../secrets;
    identityPaths = [
      "/home/${user}/.config/age/keys.txt"
    ];
    recipientAliases = {
      master = "age13ndha26pyk8jnhml5p7skurcxzwpf2zh3jj5lj2ru3n36dadhvhseat6cg";
    };
    secrets = {
      # recipients receive the age key to unlock their respective secrets
      # ssh key
      ssh-key = {
        recipients = ["master"];
        owner = user;
        group = "users";
        mode = "0600";
      };

      opencode = {
        recipients = ["master"];
        owner = user;
        group = "users";
        mode = "0600";
      };

      tailscale = {
        recipients = ["master"];
        owner = user;
        group = "users";
        mode = "0600";
      };

      password = {
        recipients = ["master"];
        owner = user;
        group = "users";
        mode = "0600";
      };

      gh-token = {
        recipients = ["master"];
        owner = user;
        group = "users";
        mode = "0600";
      };
    };
  };
}
