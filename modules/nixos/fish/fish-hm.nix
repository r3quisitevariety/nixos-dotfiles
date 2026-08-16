{...}: {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
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

      # wraps tack around gh auth token to bypass rate limits
      # omits the need for programs.tack.nixConfTokens = true;
      # also stays platform agnostic rather than being locked to nixOS
      # use gh auth login to configure the credentials
      function tack
        set -lx GH_TOKEN (gh auth token)
        command tack $argv
      end
    '';
  };
}
