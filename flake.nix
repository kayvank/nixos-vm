{
  description = "flake nixos vm";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }@inputs:

    inputs.flake-utils.lib.eachDefaultSystem(system: rec {

      pkgs = nixpkgs.legacyPackages.${system};

      nixosConfigurations.devmachine = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs.input = inputs;
        modules = [./configuration.nix];
      };

      apps = {
        default = {
          type = "app";
          program =
            "${nixosConfigurations.devmachine.config.system.build.vm}/bin/run-nixos-vm";
        };
      };
    });
  nixConfig = {
    extra-substituters = [
      "https://cache.iog.io"
    ];
    extra-trusted-public-keys = [
      "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
    ];
    allow-import-from-derivation = true;
  };

}
