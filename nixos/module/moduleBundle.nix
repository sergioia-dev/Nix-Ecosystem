{ ... }:
{
  imports = [
    ../module/system/systemBundle.nix
    ../module/database/databaseBundle.nix
    ../module/tool/toolBundle.nix
    ../module/specialization/server.nix
    ../module/tool/tailscale.nix
  ];
}
