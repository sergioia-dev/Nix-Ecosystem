{
  lib,
  config,
  ...
}:
{
  options.tool.virtManager.enable = lib.mkEnableOption ''
    Enables Virtual Manager.

    Run after installing this:  sudo virsh net-autostart default
  '';

  config = lib.mkIf config.tool.virtManager.enable {
    users.users.sia.extraGroups = [ "libvirtd" ];
    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;
    virtualisation.spiceUSBRedirection.enable = true;
  };
}
