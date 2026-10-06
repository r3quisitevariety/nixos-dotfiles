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
      copyparty
      ;
  in {
    nixosConfigurations.nitro5 = let
      user = "zx";
    in
      nixpkgs.lib.nixosSystem {
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
              backupFileExtension = "backup";
            };
          }
        ];
      };

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
              backupFileExtension = "backup";
            };
          }
        ];
      };
  };
}
