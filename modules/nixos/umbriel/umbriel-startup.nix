{
  inputs,
  pkgs,
  ...
}: {
  # NixOS
  imports = [inputs.umbriel.nixosModules.default];
  programs.umbriel = {
    enable = true;
    portalPackage = pkgs.xdg-desktop-portal-umbriel;
  };
  services.xserver.videoDrivers = ["nvidia"];
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
    config.umbriel.default = [
      "umbriel"
      "gtk"
    ];
  };
}
