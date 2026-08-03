{
  description = "One flake to rule them All";

  nixConfig = {
    substituters = [
      "https://aseipp-nix-cache.global.ssl.fastly.net"
      "https://cache.nixos.org" # Keep official as fallback
    ];
    extra-substituters = [ "https://noctalia.cachix.org" ];
    extra-trusted-public-keys = [
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    overleaf = {
      url = "gitlab:sergioia-dev/overleaf-nix";
      # url = "git+file:///home/sia/Nix-Overleaf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia/legacy-v4";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };
  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      ...
    }@inputs:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
    in
    {
      nixosConfigurations = {
        desktop-work = lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs pkgs-unstable; };
          modules = [
            ./nixos/host/work-laptop/configuration.nix
          ];
        };

        desktop-personal = lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs pkgs-unstable; };
          modules = [
            ./nixos/host/personal-laptop/configuration.nix
          ];
        };

        server = lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs pkgs-unstable; };
          modules = [
            ./nixos/server/configuration.nix
          ];
        };
      };

      homeConfigurations.sia = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."${system}";
        modules = [
          ./home-manager/home.nix
        ];

        extraSpecialArgs = { inherit inputs pkgs-unstable; };
      };
    };
}
