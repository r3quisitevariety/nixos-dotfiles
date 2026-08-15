{pkgs, ...}: {
  # credits to stella for parts of the config :D
  home.packages = [pkgs.zsh-completions];

  programs.zoxide.enableZshIntegration = true;

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    #completionInit = ''
    #  fpath=(${pkgs.nh}/share/zsh/site-functions $fpath)
    #  autoload -U compinit && compinit
    #'';
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    autocd = true;

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "copyfile"
        "copybuffer"
      ];
    };

    initContent = ''
      zstyle ':completion:*:descriptions' format '[%d]'
      zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
      function zvm_after_init() { bindkey '^ ' autosuggest-accept }


      open() { xdg-open "$@" >/dev/null 2>&1 & }

      # yazi: change to the directory it was last in when it exits.
      ya() {
        local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
        yazi "$@" --cwd-file="$tmp"
        if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
          cd -- "$cwd"
        fi
        rm -f -- "$tmp"
      }

      delete-generations() {
        sudo nix-env --delete-generations "$@" --profile /nix/var/nix/profiles/system
      }

      # Wrap tack around the gh auth token to bypass rate limits.
      # Use gh auth login to configure the credentials.
      tack() {
        GH_TOKEN="$(gh auth token)" command tack "$@"
      }
    '';

    plugins = [
      {
        name = "zsh-nix-shell";
        src = pkgs.zsh-nix-shell;
        file = "share/zsh-nix-shell/nix-shell.plugin.zsh";
      }
      {
        name = "nix-zsh-completions";
        src = pkgs.nix-zsh-completions;
        file = "share/zsh/plugins/nix-zsh-completions/nix-zsh-completions.plugin.zsh";
      }
      {
        name = "fzf-tab";
        src = pkgs.zsh-fzf-tab;
        file = "share/fzf-tab/fzf-tab.plugin.zsh";
      }
    ];
  };
}
