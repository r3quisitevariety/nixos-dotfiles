{
  description = "twinky femboy flake";

  # using tack to manage inputs
  # args form is from tack's README
  outputs = {self, ...} @ args: let
    user = "zx";

    inputs = (import ./.tack) {
      overrides = args.tackOverrides or {};
    };
    inherit
      (inputs)
      nixpkgs
      home-manager
      #nix-cachyos-kernel
      #nur
      copyparty
      ;
  in {
    #nixos + nvidia config
    nixosConfigurations.nitro5 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs user;};
      modules = [
        ./hosts/nitro5
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = {inherit inputs user;};
            users.${user} = import ./hosts/nitro5/home.nix;
            #for standalone, run home-manager switch -b backup
            backupFileExtension = "backup";
          };
        }
      ];
      #({pkgs, ...}: {
      #  nixpkgs.overlays = [
      #    # Use the exact nixpkgs revision as defined in this repo to ensure binary cache hits.
      #    #nix-cachyos-kernel.overlays.pinned
      #    #NUR overlay for browser extensions (firefox-addons)
      #    #nur.overlays.default
      #  ];
      #  # ... your other configs
      #})
    };

    #homelab config
    # onoruu is a legacy username, ill change it if i reinstall
    nixosConfigurations.inspiron = let
      user = "onoruu";
    in
      nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs user copyparty;};
        modules = [
          ./hosts/inspiron
          home-manager.nixosModules.home-manager
          copyparty.nixosModules.default
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {inherit inputs user;};
              users.${user} = import ./hosts/inspiron/home.nix;
              #for standalone, run home-manager switch -b backup
              backupFileExtension = "backup";
            };
          }
        ];
      };

    #ubuntu server config
    #homeConfigurations.black = home-manager.lib.homeManagerConfiguration {
    #  pkgs = import nixpkgs {
    #    system = "x86_64-linux";
    #    overlays = [nur.overlays.default];
    #  };
    #  extraSpecialArgs = {inherit inputs user;};
    #  modules = [
    #    ./hosts/ubuntu-inspiron/home.nix
    #  ];
    #};
  };
}
