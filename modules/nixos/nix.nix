{pkgs, ...}: {
  nix.package = pkgs.lixPackageSets.stable.lix;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nix.settings = {
    extra-substituters = [
      "https://noctalia.cachix.org"
    ];
    extra-trusted-public-keys = [
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
    ];
  };
}
