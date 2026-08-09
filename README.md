<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/522774be-ca80-4658-b1fc-9862e1e034dd" />
<img width="1920" height="1080" alt="Screenshot from 2026-08-09 14-43-23" src="https://github.com/user-attachments/assets/3144da4e-4a1a-458d-8c6c-61ccb560d3ed" />

### overview 

multi-host nixos config with flakes, tack, home-manager, & nix-secrets

- top level `flake.nix` takes in all inputs via `.tack/` and passes them to hosts
- `hosts/` contains separate hosts & their respective configurations
- `modules/` contains host-agnostic modules that are both nixos specific and/or home-manager specific
- `normie-dots/` — stuff using `mkOutOfStoreSymlink` or `home.file` goes here
- `secrets/` uses [nix-secrets](https://github.com/unnamed-systems/nix-secrets)


