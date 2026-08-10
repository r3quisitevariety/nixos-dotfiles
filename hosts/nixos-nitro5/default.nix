{...}: {
  imports = [
    # home.nix is imported through flake
    ./configuration.nix
    ../../modules/nixos/noctalia-greeter.nix
    ../../modules/nixos/vr.nix
    ../../modules/nixos/secrets.nix
  ];
}
