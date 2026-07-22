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
    inputs@{ nixpkgs, ... }:
    let
      testPasses = import ./tests { inherit (nixpkgs) lib; };
      integrationFixture = inputs.flake-parts.lib.mkFlake { inherit inputs; } {
        systems = [ "aarch64-darwin" ];
        imports = [ ./flake-module.nix ];
        nixConfigFramework = {
          root = ./tests/integration;
          extraSpecialArgsFor = { kind, ... }: { targetKind = kind; };
        };
      };
      embeddedHomeTargetKind =
        integrationFixture.darwinConfigurations.fixture.config.home-manager.users.alice.home.sessionVariables.FRAMEWORK_TARGET_KIND;
    in
    {
      lib = import ./lib { inherit (nixpkgs) lib; };
      flakeModules.default = import ./flake-module.nix;
      checks.x86_64-linux.discovery =
        assert testPasses;
        assert embeddedHomeTargetKind == "home";
        nixpkgs.legacyPackages.x86_64-linux.runCommandNoCC "discovery" { } "touch $out";
    };
}
