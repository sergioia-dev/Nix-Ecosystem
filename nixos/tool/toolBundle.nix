{...}: {
  imports = [
    ./docker.nix
    ./podman.nix
    ./nginx.nix
    ./virt-manager.nix
    ./tomcat.nix
    ./steam.nix
  ];
}
