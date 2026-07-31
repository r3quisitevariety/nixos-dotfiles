{pkgs, ...}: {
  home.file.".config/yt-dlp/music-config".text = ''
    #--cookies-from-browser brave
    -o "%(title)s.%(ext)s"
    -f bestaudio
    --extract-audio
    --convert-thumbnails png
    --ppa "ThumbnailsConvertor+ffmpeg_o:-c:v png -vf crop=\"'if(gt(ih,iw),iw,ih)':'if(gt(iw,ih),ih,iw)'\""
    --embed-thumbnail
    --embed-metadata
    --parse-metadata "playlist_index:%(track_number)s"
    --no-overwrites
    --concurrent-fragments 4
  '';

  home.packages = [
    (pkgs.writeShellApplication {
      name = "yt-music-dlp";
      runtimeInputs = [pkgs.yt-dlp pkgs.ffmpeg];
      text = ''
        yt-dlp --config-location "$HOME/.config/yt-dlp/music-config" "$1"
      '';
    })
  ];
}
