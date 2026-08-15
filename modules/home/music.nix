{
  pkgs,
  config,
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

  programs.zsh.initContent = ''
    rmpc() { command rmpc update && command rmpc "$@" }
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
}
