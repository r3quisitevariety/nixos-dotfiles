{pkgs, ...}: {
  # merge boilerplate into one TODO
  # in respective configuration.nix's
  #users.users."nix".shell = pkgs.fish;
  #users.users."onoruu".shell = pkgs.fish;

  programs.bash = {
    interactiveShellInit = ''
      # "check if parent process is not fish" && "make nested shells work properly"
      if grep -qv fish /proc/$PPID/comm && [[ $SHLVL == [12] ]]; then
          # set $SHELL for better integration with programs like nix shell, tmux, etc.
          SHELL=${pkgs.fish}/bin/fish exec fish
      fi
    '';
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source # allows fish in nix-shell

      # fix tmux not working over ssh with kitty
      if set -q SSH_CONNECTION; and test "$TERM" = xterm-kitty
        set -gx TERM xterm-256color
      end
    '';
  };
}
