{
  config,
  pkgs,
  inputs,
  user,
  ...
}: {
  # BLAZINGLY FAST ITS MEMORY SAFE GUYS
  security.sudo-rs.enable = true;

  # used as label for last major system edit; useful when picking generations at boot
  # system.nixos.label = "niri-cursor-smaller";

  services.openssh = {
    enable = true;
    openFirewall = true;
  };

  systemd.coredump.enable = false;
  boot.kernel.sysctl."kernel.core_pattern" = "/dev/null";

  imports = [
    ./hardware-configuration.nix
  ];

  services.locate.enable = false;

  programs.steam.enable = true;
  programs.niri.enable = true;

  services.power-profiles-daemon.enable = true; # switch between performance, balance, or battery saving
  services.upower.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = ["acpi_backlight=native"]; # fix backlight

  networking = {
    hostName = "nitro5";
    networkmanager.enable = true;
    firewall.enable = true;
  };

  networking.firewall.allowedTCPPorts = [8384];

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        ControllerMode = "dual";
        Experimental = true;
        FastConnectable = true;
      };
      Policy.AutoEnable = true;
    };
  };

  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales = [
    "en_CA.UTF-8/UTF-8"
    "en_US.UTF-8/UTF-8"
    "ja_JP.UTF-8/UTF-8"
    "zh_CN.UTF-8/UTF-8"
    "ko_KR.UTF-8/UTF-8"
  ];

  fonts.packages = with pkgs; [
    inter
    noto-fonts
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif # optional, for serif contexts
  ];

  fonts.fontconfig.defaultFonts = {
    serif = ["Noto Serif"];
    sansSerif = ["Inter" "Noto Sans"];
    monospace = ["JetBrains Mono"];
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.${user} = {
    isNormalUser = true;
    description = user;
    shell = pkgs.fish;
    extraGroups = ["networkmanager" "wheel"];
    hashedPasswordFile = "/run/nix-secrets/secrets/password";
    packages = with pkgs; [
    ];
  };

  programs.firefox.enable = true;
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    #inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.nixcu.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.ncr.packages.${pkgs.stdenv.hostPlatform.system}.default

    noctalia
    noctalia-greeter
    papirus-icon-theme
    xwayland-satellite
    wl-clipboard

    nicotine-plus
    picard

    obsidian
    #anki - experiencing build problems, use nix run instead
    nautilus
    foot
    google-chrome
    mpv
    mpvpaper
    proton-vpn
    keepassxc

    nwg-look
    adw-gtk3
    kdePackages.qt6ct

    kdePackages.kdenlive
    reaper
    krita
  ];

  programs.gpu-screen-recorder = {
    enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
    config.common = {
      default = "hyprland;gtk";
    };
  };

  # TODO split into separate tailscale module later
  # run sudo tailscale login after enabling service
  services.tailscale = {
    enable = true;
    openFirewall = true;
    authKeyFile = "/run/nix-secrets/secrets/tailscale";
  };

  systemd.network.wait-online.enable = false;
  boot.initrd.systemd.network.wait-online.enable = false;

  # ooooo you want to change this value ooooooo
  system.stateVersion = "26.05";
}
