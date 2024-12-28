{ config, lib, pkgs, ... }: {

  # customize kernel version
  boot.kernelPackages = pkgs.linuxPackages_5_15;
  imports = [
    ./personal.nix
  ];

  # Auto-login the default user on consoles
  services.getty.autologinUser = "dev";
  services.openssh.enable = true;

# Set up some programs
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    configure = {
      customRC = ''
        set shiftwidth=2
        set tabstop=2
        set expandtab
      '';
    };
  };

  programs.git.enable = true;
  environment.systemPackages = with pkgs; [
    ripgrep
  ];
 nixpkgs.config.allowUnfree = true;
 programs.direnv.enable = true;
  virtualisation.vmVariant.virtualisation = {
    # qemu.options = [ "-vga virtio" ];
    # Don't persist any state, also allows Ctrl-C without problems
    diskImage = null; # "./nixos.qcow2";
    # Except the current directory, which is shared in /etc/nixos
    sharedDirectories.share = {
      source = "$DEV_DIR";
      target = "/home/dev";
    };
    # Allows Nix commands to re-use and write to the host's store
    mountHostNixStore = true;
    writableStoreUseTmpfs = false;
  };


  system.stateVersion = "24.05";
}
