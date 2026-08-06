{
  description = "twinky femboy flake";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.zst";

    noctalia-greeter = {
      url = "github:noctalia-dev/noctalia-greeter";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixcord.url = "github:4evy/nixcord";

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        # IMPORTANT: To ensure compatibility with the latest Firefox version, use nixpkgs-unstable.
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-secrets.url = "github:unnamed-systems/nix-secrets";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nix-cachyos-kernel,
    nur,
    ...
  } @ inputs: {
    # will add future hosts here.

    # cachyos/arch config
    homeConfigurations.bean = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        overlays = [nur.overlays.default];
      };
      extraSpecialArgs = {inherit inputs;};
      modules = [
        ./hosts/arch-nitro5/home.nix
      ];
    };

    # ubuntu server config
    homeConfigurations.black = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        overlays = [nur.overlays.default];
      };
      extraSpecialArgs = {inherit inputs;};
      modules = [
        ./hosts/ubuntu-inspiron/home.nix
      ];
    };

    # nixos + nvidia config
    nixosConfigurations.nitro5 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};
      modules = [
        (
          {pkgs, ...}: {
            nixpkgs.overlays = [
              # Use the exact nixpkgs revision as defined in this repo to ensure binary cache hits.
              nix-cachyos-kernel.overlays.pinned
              # Alternatively, use nixpkgs from your environment, nixpkgs.config will apply.
              # Note: may not hit binary cache; kernel will need to be built locally.
              # nix-cachyos-kernel.overlays.default
              # Only use one of the two overlays!

              # NUR overlay for browser extensions (firefox-addons)
              nur.overlays.default
            ];

            # ... your other configs
          }
        )
        ./hosts/nixos-nitro5
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = {inherit inputs;};
          home-manager.users.nix = import ./hosts/nixos-nitro5/home.nix;
          #for standalone, run home-manager switch -b backup
          home-manager.backupFileExtension = "backup";
        }
      ];
    };
  };
}
