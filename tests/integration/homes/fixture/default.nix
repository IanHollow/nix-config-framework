{ modules, ... }: {
  system = "aarch64-darwin";
  username = "alice";
  homeDirectory = "/Users/alice";
  uid = 501;
  modules = [ modules.target-kind ];
}
