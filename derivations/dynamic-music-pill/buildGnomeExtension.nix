{
  pkgs,
  lib,
  stdenv,
  fetchzip,
  nixosTests,
}: let
  buildGnomeExtension = {
    uuid,
    name,
    pname,
    description,
    link,
    version,
    sha256,
    metadata,
  }:
    stdenv.mkDerivation {
      pname = "gnome-shell-extension-${pname}";
      version = toString version;
      src = fetchzip {
        url = "https://extensions.gnome.org/extension-data/${
          builtins.replaceStrings ["@"] [""] uuid
        }.v${toString version}.shell-extension.zip";
        inherit sha256;
        stripRoot = false;
        postFetch = ''
          echo "${metadata}" | base64 --decode > $out/metadata.json
        '';
      };
      nativeBuildInputs = with pkgs; [buildPackages.glib];
      buildPhase = ''
        runHook preBuild
        if [ -d schemas ]; then
          glib-compile-schemas --strict schemas
        fi
        runHook postBuild
      '';
      installPhase = ''
        runHook preInstall
        mkdir -p $out/share/glib-2.0/schemas/
        if [ -d schemas ] && [ -f schemas/*.gschema.xml ]; then
          glib-compile-schemas --strict schemas
          if [ -f schemas/gschemas.compiled ]; then
            cp schemas/gschemas.compiled $out/share/glib-2.0/schemas/
          fi
          cp schemas/*.gschema.xml $out/share/glib-2.0/schemas/
        fi
        mkdir -p $out/share/gnome-shell/extensions/
        cp -r -T . $out/share/gnome-shell/extensions/${uuid}
        runHook postInstall
      '';
      meta = {
        description = builtins.head (lib.splitString "\n" description);
        longDescription = description;
        homepage = link;
        license = lib.licenses.gpl2Plus;
        platforms = lib.platforms.linux;
      };
      passthru = {
        extensionPortalSlug = pname;
        extensionUuid = uuid;
        tests = {
          gnome-extensions = nixosTests.gnome-extensions;
        };
      };
    };
in
  lib.makeOverridable buildGnomeExtension
