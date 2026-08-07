{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.development.tool.postman.enable = lib.mkEnableOption "Enable Postman ";

  config = lib.mkIf config.development.tool.postman.enable {
    home.packages = with pkgs; [
      (pkgs.symlinkJoin {
        name = "postman";
        paths = [ pkgs.postman ];
        buildInputs = [ pkgs.makeWrapper ];
        postBuild = ''
          wrapProgram $out/bin/postman \
            --add-flags "--enable-features=UseOzonePlatform" \
            --add-flags "--ozone-platform-hint=auto"
        '';
      })
    ];
  };
}
