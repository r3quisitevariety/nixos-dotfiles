{
  inputs,
  pkgs,
  user,
  ...
}: {
  services.greetd = {
    enable = true;
    settings.default_session = {
      # will test this on reboot; push to remote if good and delete this comment
      command = "/run/current-system/sw/bin/noctalia-greeter-session -- --session niri-session";
      user = user;
    };
  };

  services.displayManager.noctalia-greeter = {
    enable = true;
    extraArgs = "";
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
}
