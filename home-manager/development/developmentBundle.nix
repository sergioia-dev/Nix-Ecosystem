{ ... }:
{
  imports = [
    ./IDE/vscode/vscode.nix
    ./IDE/jetbrains/jetbrains.nix
    ./IDE/helix/helix.nix
    ./tool/penpot.nix
    ./tool/postman.nix
    ./AI/opencode/opencode.nix
  ];
}
