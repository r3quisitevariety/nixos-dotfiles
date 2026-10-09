{...}: {
  imports = [
    ./configuration.nix
    ./secrets.nix
    ./hermes.nix
    ../../modules/nixos/nix.nix
    ../../modules/nixos/secrets.nix
    ../../modules/nixos/fish/fish-startup.nix
    ../../modules/nixos/copyparty.nix
  ];
}
