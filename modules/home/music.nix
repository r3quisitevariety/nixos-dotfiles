{
  pkgs,
  config,
  inputs,
  ...
}: {
  programs.rmpc = {
    enable = true;
  };

  programs.fish.interactiveShellInit = ''
    function rmpc
      command rmpc update
      and command rmpc $argv
    end
  '';

  programs.bash.bashrcExtra = ''
    rmpc() {
      command rmpc update && command rmpc "$@"
    }
  '';

  services.mpd = {
    enable = true;
    musicDirectory = "${config.home.homeDirectory}/Music/keepers";
    playlistDirectory = "${config.home.homeDirectory}/Music/keepers";

    extraConfig = ''
      audio_output {
        type    "pipewire"
        name    "MPD PipeWire"
        mixer_type "software"
      }
    '';
  };

  services.mpd-mpris.enable = true;
  home.packages = [pkgs.playerctl];

  home.file.".config/rmpc/config.ron" = {
    source = ../../normie-dots/config.ron;
    force = true;
  };

  home.file.".config/mprisence/config.toml".source =
    config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/nixos-dotfiles/normie-dots/config.toml";

  systemd.user.services.mprisence = {
    Unit = {
      Description = "Discord Rich Presence for MPRIS media players";
      After = ["graphical-session.target"];
      PartOf = ["graphical-session.target"];
    };
    Service = {
      ExecStart = "${pkgs.mprisence}/bin/mprisence";
      Restart = "on-failure";
      RestartSec = "5s";
    };
    Install.WantedBy = ["graphical-session.target"];
  };

  services.mpdscribble = {
    enable = true;
    endpoints = {
      "last.fm" = {
        passwordFile = "/run/nix-secrets/secrets/lastfm";
        username = "onoruu";
      };
    };
  };

  imports = [inputs.sonora.homeManagerModules.default];
  programs.sonora = {
    enable = true;
    settings = {
      provider = "youtube";
      appearance.theme = "dark";
    };
  };
}
