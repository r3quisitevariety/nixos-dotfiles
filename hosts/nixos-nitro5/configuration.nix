{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];
  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;

  services.locate.enable = false;

  programs.steam.enable = true;
  programs.hyprland.enable = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  # cachy stuff
  nix.settings.substituters = ["https://attic.xuyh0120.win/lantian"];
  nix.settings.trusted-public-keys = ["lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="];

  nix.settings = {
    extra-substituters = [
      "https://cache.nixos-cuda.org"
      "https://noctalia.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
    ];
  };

  services.power-profiles-daemon.enable = true; # switch between performance, balance, or battery saving
  services.upower.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = ["acpi_backlight=native"]; # fix backlight

  networking.hostName = "nitro5";
  networking.networkmanager.enable = true;

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      nvidia-vaapi-driver # for gpu-screen-recorder
      intel-media-driver
    ];
  };
  hardware.graphics.enable32Bit = true;
  # NVIDIA PRIME offload (Acer Nitro 5, RTX 4060)
  hardware.nvidia = {
    open = false;
    modesetting.enable = true;
    powerManagement.enable = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    prime = {
      intelBusId = "PCI:0@0:2:0";
      nvidiaBusId = "PCI:1@0:0:0";
      offload = {
        enable = true;
        enableOffloadCmd = true; # use `nvidia-offload <cmd>` to explicitly invoke dGPU
      };
    };
  };

  # modesetting driver so xserver doesn't hog the GPU in the background
  services.xserver.videoDrivers = [
    "modesetting"
    "nvidia"
  ];

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
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif # optional, for serif contexts
  ];

  #  services.xserver.enable = true;
  #services.xserver.displayManager.gdm.enable = true;
  #services.xserver.desktopManager.gnome.enable = true;

  services = {
    desktopManager.plasma6.enable = false;
    #    # Optionally enable xserver
    #    # xserver.enable = true;
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

  users.users."nix" = {
    isNormalUser = true;
    description = "nix";
    extraGroups = ["networkmanager" "wheel"];
    initialPassword = "12345";
    packages = with pkgs; [
    ];
  };

  programs.firefox.enable = true;
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # no more flake
    #inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    noctalia
    noctalia-greeter

    obsidian
    anki
    nautilus
    foot
    fuzzel
    google-chrome
    mpv
    vesktop
    proton-vpn

    nwg-look
    adw-gtk3
    kdePackages.qt6ct
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

  # ooooo you want to change this value ooooooo
  system.stateVersion = "26.05";
}
