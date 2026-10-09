{...}: {
  imports = [
    ./configuration.nix
    ../../modules/nixos/noctalia-greeter.nix
    ../../modules/nixos/vr.nix
    ../../modules/nixos/nvidia.nix
    ../../modules/nixos/nix.nix
    ../../modules/nixos/secrets.nix
    ../../modules/nixos/fish/fish-startup.nix
    ../../modules/nixos/obs.nix
  ];
}
