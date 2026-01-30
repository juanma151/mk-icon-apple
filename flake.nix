# vim: filetype=nix: tabstop=2: shiftwidth=2: expandtab:
{
  description = "Wrapper zsh to generate Apple icons using icnsutil";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.11-darwin";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs @ {
    flake-parts,
    nixpkgs,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = [
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];

      perSystem = {pkgs, ...}: let
        mkIconApple = pkgs.callPackage ./default.nix {
          pythonPkg = pkgs.python313;
        };
      in {
        packages = {
          inherit mkIconApple;
          default = mkIconApple;
        };
      };
    };
}
