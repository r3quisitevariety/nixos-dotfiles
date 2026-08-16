{
  inputs,
  pkgs,
  user,
  ...
}: {
  imports = [
    inputs.noctalia-greeter.nixosModules.default
  ];

  services.greetd = {
    enable = true;
    settings.default_session = {
      # will test this on reboot; push to remote if good and delete this comment
      command = "/run/current-system/sw/bin/noctalia-greeter-session -- --session niri-session";
      user = user;
    };
  };

  programs.noctalia-greeter = {
    enable = true;
    package = inputs.noctalia-greeter.packages.${pkgs.stdenv.hostPlatform.system}.default;

    # Optional configuration
    greeter-args = "";
    settings = {
      cursor = {
        theme = "Bibata-Modern-Ice";
        size = 20;
        path = "${pkgs.bibata-cursors}/share/icons";
      };
      keyboard = {
        layout = "us";
      };
    };
  };

  nix.settings = {
    extra-substituters = [
      "https://noctalia.cachix.org"
    ];
    extra-trusted-public-keys = [
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
    ];
  };
}
