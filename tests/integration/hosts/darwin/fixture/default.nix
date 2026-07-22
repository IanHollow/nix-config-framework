_: {
  system = "aarch64-darwin";
  hostName = "fixture";
  modules = [ { system.stateVersion = 6; } ];

  homes.alice.config = "alice@fixture";
}
