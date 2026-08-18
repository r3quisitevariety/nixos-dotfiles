{
  nixpkgs.overlays = [
    (final: prev: {
      refern = final.stdenv.mkDerivation rec {
        pname = "refern";
        version = "1.5.0";

        src = final.fetchurl {
          url = "https://storage.googleapis.com/refern-releases/releases/v${version}/refern-${version}-1.x86_64.rpm";
          hash = "sha256-6xJEdALDf7vrJFOo/PbreOSegQ8hnhaedtHTn2oXcqo=";
        };

        nativeBuildInputs = with final; [
          autoPatchelfHook
          makeWrapper
          rpmextract
          wrapGAppsHook4
        ];

        buildInputs = with final; [
          glib
          gst_all_1.gst-libav
          gst_all_1.gst-plugins-bad
          gst_all_1.gst-plugins-good
          gtk3
          libayatana-appindicator
          libdrm
          libgbm
          libGL
          libheif
          libsoup_3
          wayland
          webkitgtk_4_1
        ];

        unpackPhase = ''
          rpmextract $src
        '';

        installPhase = ''
          mkdir -p $out
          mv usr/* $out/

          wrapProgram $out/bin/refern \
            --prefix LD_LIBRARY_PATH : ${final.lib.makeLibraryPath buildInputs}
        '';

        meta = {
          description = "Visual reference manager";
          homepage = "https://refern.app";
          license = final.lib.licenses.unfree;
          platforms = ["x86_64-linux"];
          mainProgram = "refern";
        };
      };
    })
  ];
}
