{
  description = "My first Nix-flake configuration.";

  nixConfig = {
    substituters = [
      "https://mirrors.cernet.edu.cn/nix-channels/store"
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
  };

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    nixpkgs-2405 = {
      url = "github:NixOS/nixpkgs/nixos-24.05";
    };
    nixpkgs-musescore444 = {
      url = "github:NixOS/nixpkgs/ecb95bc697b31a4f2cc1852a7c5ec2fa2c04fc58";
    };
    linyinfeng-717ab9baaaca4fe6ae7dfd037a480de9dfce51fb = {
      url = "github:linyinfeng/nur-packages/717ab9baaaca4fe6ae7dfd037a480de9dfce51fb";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak = {
      url = "github:gmodena/nix-flatpak/?ref=latest";
    };
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };
    mohan-nixvim = {
      url = "github:barnard33-233/nixvim/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    paste-bin = {
      url = "github:w4/bin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nix-flatpak,
    nixos-hardware,
    paste-bin,
    ... 
    }@inputs: 
  {
    nixosConfigurations = {


      # a vm conf for my currently not existing vps
      vps = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./machine/vps/host/configuration.nix
        ];
        specialArgs = {inherit inputs; };
      };

      laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./machine/laptop/host/configuration.nix
          nixos-hardware.nixosModules.asus-zephyrus-ga503
          nix-flatpak.nixosModules.nix-flatpak
          home-manager.nixosModules.home-manager {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.tang_ = import ./machine/laptop/home/home.nix;
              extraSpecialArgs = { inherit inputs; };
            };
          }
        ];
      };

    };
  };
}
