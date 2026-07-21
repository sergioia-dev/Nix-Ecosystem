{
  imports = [
    ./profile/battery/set-battery-limit.nix
    ./desktop/gnome/gnomeModule.nix
    ./desktop/kdePlasma/kdePlasmaModule.nix
    ./desktop/cosmic/cosmicModule.nix
    ./hardware/hardware-configuration.nix
    ./shell/zsh.nix
  ];
}
