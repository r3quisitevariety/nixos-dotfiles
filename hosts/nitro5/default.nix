{...}: {
  imports = [
    # home.nix is imported through flake
    # import tree this shit soon
    ./configuration.nix
    ../../modules/nixos/noctalia-greeter.nix
    ../../modules/nixos/vr.nix
    ../../modules/nixos/nvidia.nix
    ../../modules/nixos/nix.nix
    ../../modules/nixos/cachy.nix
    ../../modules/nixos/secrets.nix
    ../../modules/nixos/fish/fish-startup.nix
    #../../modules/nixos/umbriel/umbriel-startup.nix
  ];
}
