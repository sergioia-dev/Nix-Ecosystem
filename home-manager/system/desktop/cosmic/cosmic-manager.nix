{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    inputs.cosmic-manager.homeManagerModules.default
  ];
}