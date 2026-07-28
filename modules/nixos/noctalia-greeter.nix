{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.noctalia-greeter.nixosModules.default
  ];

  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "/run/current-system/sw/bin/noctalia-greeter-session -- --session Hyprland";
      user = "nix";
    };
  };

  programs.noctalia-greeter = {
    enable = true;
    package = inputs.noctalia-greeter.packages.${pkgs.stdenv.hostPlatform.system}.default;

    # Optional configuration
    greeter-args = "";
    settings = {
      cursor = {
        theme = "Breeze";
        size = 20;
      };
      keyboard = {
        layout = "us";
      };
    };
  };
}
