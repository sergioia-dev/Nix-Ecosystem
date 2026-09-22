{
  imports = [
    ./profile/battery/battery-limit.nix
    ./profile/script/windows-boot.nix
    ./desktop/gnome/gnomeModule.nix
    ./desktop/kdePlasma/kdePlasmaModule.nix
    ./desktop/cosmic/cosmicModule.nix
    ./desktop/niri/niriModules.nix
    ./shell/zsh.nix
  ];
}
