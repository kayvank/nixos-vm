{ config, lib, pkgs, ... }:

{
  users.groups.admin = {};
  users.users = {
    dev = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      initialPassword = "test";
      group = "admin";
    };
  };
  users.extraUsers.root.password = "";
  security.sudo.wheelNeedsPassword = false;
  nix.settings.trusted-users = [ "root" "@wheel" ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  ## setup cache ##
  ##
nix.settings = {
  trusted-substituters = [ "https://cache.iog.io" ];
  trusted-public-keys = [ "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ=" ];
};

  # Set this to a portion of your host machine's resources
  virtualisation.vmVariant.virtualisation = {
    # graphics = true;
    # 8 cores
    cores = 8;
    # 16GB RAM
    memorySize = 16 * 1024;
    forwardPorts = [
      { from = "host"; host.port = 2222; guest.port = 22; }
      { from = "host"; host.port = 1883; guest.port = 1883; }
    ];

  };

  # Set this to your timezone (run `tzselect`)
  time.timeZone = "America/Los_Angeles";
}
