{
  pkgs,
  inputs,
  user,
  copyparty,
  ...
}: {
  # my homelab config

  security.sudo-rs.enable = true;

  # allows nh --target-host to work
  nix.settings = {
    trusted-users = ["root" "@wheel"];
  };

  services.openssh = {
    enable = true;
    openFirewall = true;
  };

  services.tailscale = {
    enable = true;
    openFirewall = true;
    authKeyFile = "/run/nix-secrets/secrets/tailscale";
  };

  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "inspiron"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Define a user account.
  users.users.${user} = {
    isNormalUser = true;
    description = user;
    shell = pkgs.fish;
    hashedPasswordFile = "/run/nix-secrets/secrets/password";
    extraGroups = ["networkmanager" "wheel" "docker"];
    packages = with pkgs; [
      #  thunderbird
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    inputs.nixcu.packages.${pkgs.stdenv.hostPlatform.system}.default
    neovim
    vim
  ];

  services.immich = {
    enable = true;
    host = "0.0.0.0";
    openFirewall = true;
  };
  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };
  services.slskd = {
    enable = true;
    openFirewall = true;
    environmentFile = "/run/nix-secrets/secrets/slskd";
    user = "slskd";
    group = "slskd";
  };

  networking.firewall.allowedTCPPorts = [8384];

  #freshrss (not fun on nix), soulseek
  virtualisation.docker = {
    enable = true;
    daemon.settings = {
      "log-driver" = "json-file";
      "log-opts" = {
        "max-size" = "10m";
        "max-file" = "3";
      };
    };
  };

  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  system.stateVersion = "26.05";
}
