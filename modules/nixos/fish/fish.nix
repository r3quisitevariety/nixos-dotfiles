{pkgs, ...}: {
  # imported from respective home.nix's
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source # allows fish in nix-shell

      # fix tmux not working over ssh with kitty
      if set -q SSH_CONNECTION; and test "$TERM" = xterm-kitty
        set -gx TERM xterm-256color
      end

      function ya
        set tmp (mktemp -t "yazi-cwd.XXXXXX")
        yazi $argv --cwd-file="$tmp"

        if set -l cwd (cat -- "$tmp"); and test -n "$cwd"; and test "$cwd" != "$PWD"
          builtin cd -- "$cwd"
        end

        rm -f -- "$tmp"
      end

      function delete-generations
        sudo nix-env --delete-generations $argv --profile /nix/var/nix/profiles/system
      end

    '';
  };
}
