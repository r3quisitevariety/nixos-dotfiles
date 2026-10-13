{
  config,
  pkgs,
  ...
}: {
  # config for doom emacs; installed the imperative way with git clone; .config/doom will live in a separate repo
  # i dont want to bother using nix to replace doom's package manager or to configure doom
  home.packages = with pkgs; [
    emacs
    ripgrep
    fzf
    fd
    git
    clang
    coreutils
  ];

  home.sessionPath = [
    "$HOME/.config/emacs/bin"
  ];
  programs.fish.interactiveShellInit = ''
    # run doom sync to create early-init.el which allows the desktop entry to work
    fish_add_path --prepend --path "$HOME/.config/emacs/bin"
  '';

  xdg.desktopEntries.doom-emacs = {
    name = "Doom Emacs";
    comment = "Doom Emacs";
    exec = "${pkgs.emacs}/bin/emacs --init-directory=${config.home.homeDirectory}/.config/emacs %F";
    icon = "emacs";
    terminal = false;
    categories = ["Development" "TextEditor"];
  };
}
