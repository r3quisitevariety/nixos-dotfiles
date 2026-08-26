{
  pkgs,
  config,
  ...
}: {
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
    open = true;
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

  nix.settings = {
    extra-substituters = [
      "https://cache.nixos-cuda.org"
    ];
    extra-trusted-public-keys = [
      "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
    ];
  };
}
