{pkgs, ...}: {
  nix.package = pkgs.lixPackageSets.stable.lix;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
