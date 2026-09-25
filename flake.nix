{
  description = "My first Nix-flake configuration.";

  # nixConfig = {
  #   substituters = [
  #     # "https://mirrors.cernet.edu.cn/nix-channels/store"
  #     "https://cache.nixos.org"
  #     "https://nix-community.cachix.org"
  #   ];
  #   trusted-public-keys = [
  #       "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
  #       "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
  #   ];
  # };

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    nixpkgs-musescore444 = {
      url = "github:NixOS/nixpkgs/ecb95bc697b31a4f2cc1852a7c5ec2fa2c04fc58";
    };
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    linyinfeng-717ab9baaaca4fe6ae7dfd037a480de9dfce51fb = {
      url = "github:linyinfeng/nur-packages/717ab9baaaca4fe6ae7dfd037a480de9dfce51fb";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    xddxdd = {
      url = "github:xddxdd/nur-packages";
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
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew = {
      url = "github:zhaofengli/nix-homebrew";
    };
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    nix-darwin,
    home-manager,
    nix-flatpak,
    nixos-hardware,
    disko,
    sops-nix,
    nix-homebrew,
    homebrew-core,
    homebrew-cask,
    ...
  }@inputs:
  {
    darwinConfigurations = {
      # Mac mini m4 configuration
      Mo-macmini = nix-darwin.lib.darwinSystem {
        modules = [
          ./machine/mo-macmini/host/configuration.nix
          home-manager.darwinModules.home-manager {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.mohan = import ./machine/mo-macmini/home/home.nix;
              extraSpecialArgs = { inherit inputs; };
            }; 
          }
        ];
      };

      # Macbook pro m5 configuration
      momacbook = nix-darwin.lib.darwinSystem {
        modules = [
          ./machine/momacbook/host/configuration.nix
          home-manager.darwinModules.home-manager {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.mo = import ./machine/momacbook/home/home.nix;
              extraSpecialArgs = { inherit inputs; };
            };
          }
        ];
        specialArgs = {inherit inputs; };
      };
    };

    nixosConfigurations = {

      # dmit config
      dmit-la-00 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          disko.nixosModules.disko
          sops-nix.nixosModules.sops
          ./machine/dmit-la-00/host/configuration.nix
          ./profiles/vps.nix
        ];
        specialArgs = {inherit inputs; };
      };

      # bwg config
      bwg-sj-00 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          sops-nix.nixosModules.sops
          ./machine/bwg-sj-00/host/configuration.nix
          ./profiles/vps.nix
        ];
        specialArgs = {inherit inputs; };
      };

      # asus-zephyrus-ga503 config
      laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./machine/laptop/host/configuration.nix
          nixos-hardware.nixosModules.asus-zephyrus-ga503
          nix-flatpak.nixosModules.nix-flatpak
          sops-nix.nixosModules.sops
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
