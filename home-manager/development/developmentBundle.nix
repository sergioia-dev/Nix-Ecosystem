{ ... }:
{
  imports = [
    ./language/dart.nix
    ./language/python.nix
    ./language/nix.nix
    ./language/cpp.nix
    ./language/typescript.nix
    ./language/rust.nix
    ./language/java.nix
    ./language/lua.nix
    ./language/csharp.nix
    ./IDE/vscode/vscode.nix
    ./IDE/jetbrains/jetbrains.nix
    ./IDE/helix/helix.nix
    ./tool/penpot.nix
    ./tool/obsidian.nix
    ./tool/logseq.nix
    ./database/mysql.nix
    ./database/postgresql.nix
    ./database/redis.nix
    ./database/mongodb.nix
    ./database/sqlite.nix
    ./AI/opencode.nix
  ];
}
