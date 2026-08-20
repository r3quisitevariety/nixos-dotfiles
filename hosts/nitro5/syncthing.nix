{...}: {
  # this is hm managed
  # nitro5's syncthing.nix
  networking.firewall.allowedTCPPorts = [8384];
  services.syncthing = {
    enable = true;
    overrideDevices = true;
    overrideFolders = true;
    settings = {
      folders = {
        masterplan = {
          devices = ["pixel-8-pro" "inspiron"];
          id = "mg7tu-y2qmx";
          name = "nitro5";
          enable = true;
          path = "~/Documents/masterplan";
          type = "sendreceive";
        };
        obsidian = {
          devices = ["pixel-8-pro" "inspiron"];
          id = "lmski-53ald";
          name = "nitro5";
          enable = true;
          path = "~/Documents/obsidian";
          type = "sendreceive";
        };
        music = {
          devices = ["pixel-8-pro" "inspiron"];
          id = "gds2p-nvu34";
          name = "nitro5";
          enable = true;
          path = "~/Music";
          type = "sendreceive";
        };
        wallpapers = {
          devices = ["inspiron"];
          id = "a27nj-kwhuv";
          name = "nitro5";
          enable = true;
          path = "~/Pictures/wallpapers";
          type = "sendreceive";
        };
      };
      # requires tailscale to be up
      devices = {
        "inspiron" = {
          id = "5GJ7RM4-XDHAH2C-GRILLAD-E4ZVXGK-LN2VWII-GO4VQRO-EFYRPXY-QEZ43QG";
        };

        "pixel-8-pro" = {
          id = "QVJASTB-JBK7QRK-W2ZRNKP-6G66XQM-7JVRJ5B-OHN57XC-IEM3VWM-QNHR6AV";
        };
      };
    };
  };
}
