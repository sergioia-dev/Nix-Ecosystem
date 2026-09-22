{ inputs, ... }:
{
  imports = [
    ../../common/base.nix
    ../../common/hardware/personal-laptop.nix
  ];

  system = {
    specialization.server.enable = true;
  };
}