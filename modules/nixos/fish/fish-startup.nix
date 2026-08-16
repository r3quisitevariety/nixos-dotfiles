{pkgs, ...}: {
  # does nixos specific stuff for proper fish startup

  # merge boilerplate into one TODO
  # in respective configuration.nix's:
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
  };
}
