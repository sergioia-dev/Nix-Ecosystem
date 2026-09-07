{
  inputs,
  config,
  lib,
  ...
}:

{
  imports = [
    inputs.cosmic-manager.homeManagerModules.default
  ];
}
