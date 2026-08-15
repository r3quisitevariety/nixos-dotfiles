{pkgs, ...}: {
  #  The option `home-manager.users.nix.nix.package' is defined multiple times while it's expected to be unique.
  #nix.package = pkgs.lixPackageSets.stable.lix;
  # make sure .bashrc and bash_profile are removed locally, otherwise home manager will give you an error as it does not want to delete the files.

  programs.opencode = {
    enable = true;
  };

  programs.carapace = {
    enable = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
  };
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
  };

  home.shellAliases = {
    cd = "z";
    lg = "lazygit";
    neofetch = "fastfetch";
    v = "nvim";
    g = "git";
    cp = "cp -r";
    ls = "eza --color=auto";
    grep = "grep --color=auto";
    yay = "paru";
    notes = "cd ~/Documents/masterplan && nvim";
    upgrade = "nh os switch ~/nixos-dotfiles --update";
    less = "moor";
    ns = "nix-search-tv print | fzf --preview 'nix-search-tv preview {}' --scheme history";
    t = "tmux";
    bunnyfetch = "fastfetch";
    oc = "opencode";
  };

  #nixos specific code is required to start up fish (check configuration.nix)
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

  programs.bash = {
    enable = true;
    bashrcExtra = ''
      PS1='\[\e[1;32m\]\u@\h\[\e[0m\]:\[\e[1;34m\]\w\[\e[0m\]\$ '

      function ya() { # yazi: cd into cwd on quit
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

      # wraps tack around gh auth token to bypass rate limits
      # omits the need for programs.tack.nixConfTokens = true;
      # also stays platform agnostic rather than being locked to nixOS
      # use gh auth login to configure the credentials
      tack() {
        GH_TOKEN="$(gh auth token)" command tack "$@"
      }

    '';
  };
  home.sessionVariables = {
    VISUAL = "vim";
    EDITOR = "vim";
  };

  home.packages = with pkgs; [
    duf # disk usage utility
    tack
    neocities
    imv
    github-cli
    nix-search-tv
    moor
    dix
    w3m
    diskonaut-ng
    tokei
    git
    fastfetch
    hyfetch
    yazi
    go-grip
    lazygit
    ranger
    htop
    btop
    nh
    microfetch
    unar
    fzf
    ripgrep
    fd
    bat
    eza
    tree
    tldr
    curl
    wget
    yt-dlp
    home-manager
    zola
    go
    bun
    rustup
  ];
  programs.tmux = {
    enable = true;
    shortcut = "b";
    escapeTime = 0;
    historyLimit = 10000;
    extraConfig = ''
      # pane navigation (hjkl)
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # pane resizing (HJKL)
      bind -r H resize-pane -L 5
      bind -r J resize-pane -D 5
      bind -r K resize-pane -U 5
      bind -r L resize-pane -R 5

      # splits that open in current directory
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"

      set -g mouse on
      set -g set-clipboard on
      bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "wl-copy"
      bind -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "wl-copy"
    '';
  };

  programs.vim = {
    enable = true;
    defaultEditor = false;
    #package = pkgs.vim-full.customize {
    #name = "vim";
    extraConfig = ''
      set clipboard=unnamedplus
      set number
      set relativenumber
      set tabstop=2
      set shiftwidth=2
      set expandtab
      set wrap
      set linebreak
      set smartindent
      syntax on
      nnoremap <leader>w :set wrap!<CR>
    '';
  };
}
