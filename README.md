### overview 

multi-host nixos config with flakes & home-manager

- top level `flake.nix` takes in all inputs and passes them to the necessary outputs (duh)
- `hosts/` contains separate hosts & their respective configurations
- `modules/` contains host-agnostic modules that are both nixos specific and/or home-manager specific
- `normie-dots/` is such a stupid directory name but i have no reason to change it for now lol; stuff using `mkOutOfStoreSymlink` or `home.file` goes here
- `secrets/` uses [nix-secrets](https://github.com/unnamed-systems/nix-secrets)


