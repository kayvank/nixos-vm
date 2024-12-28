{
  description = "flake nixos vm";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }@inputs:
  flake-utils.lib.eachDefaultSystem(system:
  let

    pkgs = nixpkgs.legacyPackages."${system}";

    base = { lib, modulesPath, ... }: {
      imports = [ "${modulesPath}/virtualisation/qemu-vm.nix" ];

      # https://github.com/utmapp/UTM/issues/2353
      networking.nameservers = lib.mkIf pkgs.stdenv.isDarwin [ "8.8.8.8" ];
    };
    machine = nixpkgs.lib.nixosSystem {
      system = builtins.replaceStrings [ "darwin" ] [ "linux" ] system;

      modules = [ base ./vm.nix ];
    };

    program = pkgs.writeShellScript "run-vm.sh" ''
      export NIX_DISK_IMAGE=$(mktemp -u -t nixos.qcow2)

      trap "rm -f $NIX_DISK_IMAGE" EXIT

      ${machine.config.system.build.vm}/bin/run-nixos-vm
    '';

  in {
    packages = { inherit machine; };
    defaultPackage = program;
    apps.default = {
    type = "app";
    program = "${program}";
    };
  }

  );

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
