{ system, targetKind, ... }: {
  imports =
    assert system == "aarch64-darwin";
    [ ];

  home = {
    sessionVariables.FRAMEWORK_TARGET_KIND = targetKind;
    stateVersion = "25.05";
  };
}
