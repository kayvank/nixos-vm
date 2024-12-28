Stateless NixOS qemu
--
## What is this
A simple flalke project to builds a NixOs VM

## Why do I need this for
It provides a declarative way to provision a VM for experimentation. For instance, 
- test projects in a fresh vm
- create multiple nodes
- run integration tests

## How do I use it
Clone the project and either simple run the flake, or build the flake and invoke the resulted script.

+ build the flake

``` sh
nix build
DEV_DIR=/home/kayvan/dev/workspaces/workspace-q2io ./result
```
where `DEV_DIR` is the directory you wish to mount to VM

+ run the flake

``` sh
DEV_DIR=/home/kayvan/dev/workspaces/workspace-q2io nix run
```

## References
+ [nix-in-production](https://leanpub.com/nixos-in-production)
+ [nix-hour](https://github.com/tweag/nix-hour/tree/master)
+ [Nixpkgs Reference Manual](https://nixos.org/manual/nixpkgs/stable/#chap-language-support)
+ [nix-flake-book](https://nixos-and-flakes.thiscute.world/)

I also used this gist on [Setting up qemu VM using nix flakes](https://gist.github.com/FlakM/0535b8aa7efec56906c5ab5e32580adf)
