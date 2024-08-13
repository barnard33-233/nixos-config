{
  description = "My first Nix-flake configuration.";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nur.url = "github:nix-community/NUR";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, home-manager, nur, ... }@inputs: {
    nixosConfigurations = {
      mohan-nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
	  nur.nixosModules.nur
          ./hosts/mohan-nixos/configuration.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.tang_ = import ./home/home.nix;
          }
        ];
      };
    };

  };
}
