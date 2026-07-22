{ lib }:
let
  framework = import ../lib { inherit lib; };
  generic = framework.mkModuleSet ./fixture/modules/nixos;
  shared = framework.mkSharedModuleSet {
    root = ./fixture/modules/shared;
    class = "nixos";
    args = { };
  };
in
assert generic ? group;
assert generic ? group-alpha;
assert generic ? group-beta;
assert builtins.length generic.group.imports == 2;
assert shared ? cross;
true
