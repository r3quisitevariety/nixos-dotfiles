{pkgs, ...}: {
  nixpkgs.overlays = [
    (final: prev: {
      xwayland-satellite = prev.xwayland-satellite.overrideAttrs (old: {
        patches =
          (old.patches or [])
          ++ [
            # fix steam dropdowns closing instantly and unity add component not focusing
            # https://github.com/Supreeeme/xwayland-satellite/pull/494
            (final.fetchpatch2 {
              url = "https://github.com/Supreeeme/xwayland-satellite/compare/9d51b59ff3c38464e7654096c9b10a8052a26b25.diff?full_index=1";
              hash = "sha256-VpdX1V9N0pkBJoRuqTwZiwJeW4h200TdsPN75xnBSEk=";
            })
          ];
      });
    })
  ];
}
