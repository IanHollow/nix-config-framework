{
  description = "Convention-based NixOS, Home Manager, and nix-darwin configuration assembly";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    home-manager.url = "github:nix-community/home-manager";
    nix-darwin.url = "github:nix-darwin/nix-darwin";

    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    { nixpkgs, ... }:
    let
      testPasses = import ./tests { lib = nixpkgs.lib; };
    in
    {
      lib = import ./lib { lib = nixpkgs.lib; };
      flakeModules.default = import ./flake-module.nix;
      checks.x86_64-linux.discovery =
        assert testPasses;
        nixpkgs.legacyPackages.x86_64-linux.runCommandNoCC "discovery" { } "touch $out";
    };
}
