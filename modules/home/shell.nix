{
  inputs,
  pkgs,
  ...
}: {
  programs.direnv = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = false;
    nix-direnv.enable = true;
  };
  programs.yt-dlp = {
    enable = true;
    extraConfig = ''
      --cookies /run/nix-secrets/secrets/yt-dlp-cookies
    '';
  };

  programs.aria2 = {
    enable = true;
  };

  programs.eza = {
    enable = true;
    enableFishIntegration = true;
    git = true;
    icons = "auto";
    extraOptions = [
      "--header"
      "--group-directories-first"
      "--sort=type"
      "--no-permissions"
      "--hyperlink=auto"
      "--level=3"
      "--git-ignore"
      "--time=created"
      "--time-style=long-iso"
      "--short-nix"
      "--loc"
    ];
  };

  home.shellAliases = {
    tack = "sh -c 'GH_TOKEN=\"$(cat /run/nix-secrets/secrets/gh-token)\" exec tack \"$@\"' sh";
    cd = "z";
    lg = "lazygit";
    neofetch = "fastfetch";
    v = "nvim";
    g = "git";
    cp = "cp -r";
    grep = "grep --color=auto";
    yay = "paru";
    notes = "cd ~/Documents/masterplan && nvim";
    upgrade = "nh os switch ~/nixos-dotfiles --update";
    less = "moor";
    ns = "nix-search-tv print | fzf --preview 'nix-search-tv preview {}' --scheme history";
    t = "tmux";
    h = "herdr";
    oc = "opencode";
    rm = "trash";
  };

  programs.opencode = {
    enable = true;
  };

  programs.carapace = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
  };
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
  };

  programs.bash = {
    enable = true;
  };

  home.sessionVariables = {
    VISUAL = "vim";
    EDITOR = "vim";
  };

  # commonly used packages in my shell
  # rest of stuff is in direnv or i use comma for quick one-offs
  home.packages = with pkgs; [
    trash-cli
    ffmpeg
    duf # disk usage utility
    inputs.tack.packages.${pkgs.stdenv.hostPlatform.system}.tack
    imv
    github-cli
    nix-search-tv
    moor
    dix
    w3m
    diskonaut-ng
    git
    fastfetch
    hyfetch
    yazi
    go-grip
    lazygit
    htop
    btop
    nh
    microfetch
    unar
    fzf
    ripgrep
    fd
    tree
    tldr
    curl
    wget
    home-manager
    gallery-dl
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
