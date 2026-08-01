{
  imports = [
    ./profile/battery/set-battery-limit.nix
    ./desktop/gnome/gnomeModule.nix
    ./desktop/kdePlasma/kdePlasmaModule.nix
    ./desktop/cosmic/cosmicModule.nix
    ./desktop/niri/niriModules.nix
    ./shell/zsh.nix
  ];
}
