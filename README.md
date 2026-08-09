### overview 

multi-host nixos config with flakes, tack, home-manager, & nix-secrets

- top level `flake.nix` takes in all inputs via `.tack/` and passes them to hosts
- `hosts/` contains separate hosts & their respective configurations
- `modules/` contains host-agnostic modules that are both nixos specific and/or home-manager specific
- `normie-dots/` — stuff using `mkOutOfStoreSymlink` or `home.file` goes here
- `secrets/` uses [nix-secrets](https://github.com/unnamed-systems/nix-secrets)


