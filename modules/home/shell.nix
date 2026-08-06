{pkgs, ...}: {
  #  The option `home-manager.users.nix.nix.package' is defined multiple times while it's expected to be unique.
  #nix.package = pkgs.lixPackageSets.stable.lix;
  # make sure .bashrc and bash_profile are removed locally, otherwise home manager will give you an error as it does not want to delete the files.

  programs.opencode = {
    enable = true;
  };
  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
  };
  programs.bash = {
    enable = true;
    shellAliases = {
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
      ncr = "nix run github:greyxp1/ncr";
      upgrade = "nh os switch ~/nixos-dotfiles --update";
      less = "moor";
    };
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

    '';
  };
  home.sessionVariables = {
    VISUAL = "vim";
    EDITOR = "vim";
  };

  home.packages = with pkgs; [
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
