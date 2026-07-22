{ targetKind, ... }: {
  home = {
    sessionVariables.FRAMEWORK_TARGET_KIND = targetKind;
    stateVersion = "25.05";
  };
}
