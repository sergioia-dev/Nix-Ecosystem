{
  lib,
  config,
  ...
}:
{
  options.tool.tailscale = {
    enable = lib.mkEnableOption "Tailscale";
    mode = lib.mkOption {
      type = lib.types.enum [ "server" "client" ];
      default = "client";
      description = ''
        Whether this host runs Tailscale as a server or client.
        `server` sets services.tailscale.useRoutingFeatures = "server"
        (enables routing/exit features). `client` leaves routing features at
        the upstream default ("none"), so the host is a plain client.
      '';
    };
  };
  config = lib.mkIf config.tool.tailscale.enable {
    services.tailscale = {
      enable = true;
    } // lib.optionalAttrs (config.tool.tailscale.mode == "server") {
      useRoutingFeatures = "server";
    };
  };
}
