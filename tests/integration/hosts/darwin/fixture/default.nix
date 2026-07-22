{ inputs, ... }: {
  system = "aarch64-darwin";
  hostName = "fixture";
  modules = [ { system.stateVersion = 6; } ];

  homes.alice = {
    config = "alice@fixture";
    user.shell = inputs.nixpkgs.legacyPackages.aarch64-darwin.nushell;
  };
}
