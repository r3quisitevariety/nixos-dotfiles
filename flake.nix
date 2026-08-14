{
  description = "twinky femboy flake";

  # using tack to manage inputs
  # args form is from tack's README
  outputs = {self, ...} @ args: let
    inputs = (import ./.tack) {
      overrides = args.tackOverrides or {};
    };
    inherit
      (inputs)
      nixpkgs
      home-manager
      nix-cachyos-kernel
      nur
      ;
  in {
    #cachyos/arch config
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

    #ubuntu server config
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

    #nixos + nvidia config
    nixosConfigurations.nitro5 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};
      modules = [
        (
          {pkgs, ...}: {
            nixpkgs.overlays = [
              # Use the exact nixpkgs revision as defined in this repo to ensure binary cache hits.
              nix-cachyos-kernel.overlays.pinned
              #NUR overlay for browser extensions (firefox-addons)
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
          home-manager.users.nix =
            import ./hosts/nixos-nitro5/home.nix;
          #for standalone, run home-manager switch -b backup
          home-manager.backupFileExtension = "backup";
        }
      ];
    };

    #homelab config
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};
      modules = [
        ./hosts/nixos-inspiron
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = {inherit inputs;};
          home-manager.users.onoruu =
            import ./hosts/nixos-inspiron/home.nix;
          #for standalone, run home-manager switch -b backup
          home-manager.backupFileExtension = "backup";
        }
      ];
    };
  };
}
