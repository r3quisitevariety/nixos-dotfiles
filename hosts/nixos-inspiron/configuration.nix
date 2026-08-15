# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  inputs,
  ...
}: {
  users.users."onoruu".shell = pkgs.fish;
  programs.bash = {
    interactiveShellInit = ''
      # "check if parent process is not fish" && "make nested shells work properly"
      if grep -qv fish /proc/$PPID/comm && [[ $SHLVL == [12] ]]; then
          # set $SHELL for better integration with programs like nix shell, tmux, etc.
          SHELL=${pkgs.fish}/bin/fish exec fish
      fi
    '';
  };
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
  };

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
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "inspiron"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."onoruu" = {
    isNormalUser = true;
    description = "onoruu";
    extraGroups = ["networkmanager" "wheel"];
    packages = with pkgs; [
      #  thunderbird
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    inputs.nixcu.packages.${pkgs.stdenv.hostPlatform.system}.default
    neovim
    copyparty
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #  wget
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
  services.freshrss = {
    enable = true;
    baseUrl = "http://inspiron";
    defaultUser = "admin";
    passwordFile = "/run/nix-secrets/secrets/freshrss";
  };

  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  system.stateVersion = "26.05";
}
