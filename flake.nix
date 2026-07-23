{
  description = "One flake to rule them All";

  nixConfig = {
    substituters = [
      "https://aseipp-nix-cache.global.ssl.fastly.net"
      "https://cache.nixos.org" # Keep official as fallback
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
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
        desktop = lib.nixosSystem {
          inherit system;
          modules = [
            ./nixos/desktop/configuration.nix
          ];
        };

        server = lib.nixosSystem {
          inherit system;
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
