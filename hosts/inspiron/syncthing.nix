{...}: {
  # this is hm managed
  # inspiron's syncthing.nix
  services.syncthing = {
    enable = true;
    guiAddress = "0.0.0.0:8384";
    overrideDevices = true;
    overrideFolders = true;
    settings = {
      folders = {
        masterplan = {
          devices = ["pixel-8-pro" "nitro5"];
          id = "mg7tu-y2qmx";
          name = "inspiron";
          enable = true;
          path = "~/Documents/masterplan";
          type = "sendreceive";
        };
        obsidian = {
          devices = ["pixel-8-pro" "nitro5"];
          id = "lmski-53ald";
          name = "inspiron";
          enable = true;
          path = "~/Documents/obsidian";
          type = "sendreceive";
        };
        music = {
          devices = ["pixel-8-pro" "nitro5"];
          id = "gds2p-nvu34";
          name = "inspiron";
          enable = true;
          path = "~/Music";
          type = "sendreceive";
        };
        wallpapers = {
          devices = ["nitro5"];
          id = "a27nj-kwhuv";
          name = "inspiron";
          enable = true;
          path = "~/Pictures/wallpapers";
          type = "sendreceive";
        };
      };
      # requires tailscale to be up
      devices = {
        "nitro5" = {
          id = "CNFCC2L-7F733LZ-K6JDXXS-VPWFH35-652FFMC-4WG4226-ZKJSFMM-TIWQZQN";
        };

        "pixel-8-pro" = {
          id = "QVJASTB-JBK7QRK-W2ZRNKP-6G66XQM-7JVRJ5B-OHN57XC-IEM3VWM-QNHR6AV";
        };
      };
    };
  };
}
