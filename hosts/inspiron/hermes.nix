{
  inputs,
  user,
  pkgs,
  lib,
  ...
}: {
  imports = [
    inputs.hermes-agent.nixosModules.default
  ];

  systemd.services.hermes-agent.serviceConfig = {
    ProtectHome = lib.mkForce "read-only";
    ReadWritePaths = [
      "/home/onoruu/hermes"
    ];
  };

  services.hermes-agent = {
    enable = true;
    user = "onoruu";
    group = "users";
    createUser = false;
    stateDir = "/home/onoruu/hermes";
    workingDirectory = "/home/onoruu/hermes/workspace";
    addToSystemPackages = true;

    # discord, telegram, slack, etc
    extraDependencyGroups = ["messaging"];

    # stuff you want hermes to explicitly have
    extraPackages = with pkgs; [
      # BLAZINGLY FAST MEMORY SAFE
      ripgrep
      # helps with nix.... i guess...
      nh
      mcp-nixos
      imagemagick
      pandoc
      python313Packages.ddgs
    ];

    # THANKS WOLFIEEE
    mcpServers = {
      nixos = {
        command = "nix";
        args = [
          "run"
          "github:utensils/mcp-nixos"
          "--"
        ];
      };
    };

    #containers if you want them
    #container = {
    #  enable = true;
    #  backend = "docker";
    #  hostUsers = [user];
    #  # Add explicit host:container mounts here when Hermes needs access to
    #  # project directories outside /var/lib/hermes.
    #  extraVolumes = ["/home/onoruu/Documents/masterplan:/obsidian:rw"];
    #};

    # api keys, bot tokens, passwords
    environmentFiles = [
      "/run/nix-secrets/secrets/hermes-env"
    ];

    settings = {
      web.backend = "ddgs";

      backend.mode = "dashboard"; # serves the browser admin panel
      backend.host = "127.0.0.1"; # keep loopback unless you want auth gating
      backend.port = 9119;

      # done imperatively for quick switching instead
      #model = {
      #  base_url = "https://opencode.ai/zen/go/v1/";
      #  provider = "opencode-go";
      #  default = "gpt-5.6-luna";
      #  api_mode = "codex_responses";
      #};

      plugins.enabled = ["ponytail"];

      # rest of settings do not overwrite the config.yaml; feel free to leave some things imperative
      display = {
        interface = "tui";
        show_reasoning = true;
      };
      # shrinks long convos; 0.5 threshold means 50% of max context per model triggers compression
      compression = {
        enabled = true;
        threshold = 0.5;
      };
      memory = {
        # in MEMORY.md
        memory_enabled = true;
        #in USER.md for specific users
        user_profile_enabled = true;
      };
      # toolcalling settings
      agent = {
        max_turns = 50;
        disabled_toolsets = [];
      };
      approvals = {
        mode = "manual";
        timeout = 300;
        cron_mode = "deny";
        single_query_mode = "deny";
      };
      security = {
        allow_lazy_installs = false;
        redact_secrets = true;
      };
    };

    hermesHomeFiles."SOUL.md" = ''
      # Hermes personality

      You are a practical, direct assistant for ${user}, running on the host 'inspiron'.

      Prefer concise answers, but include enough detail to make commands and
      configuration changes understandable. State uncertainty instead of
      inventing facts. Before changing files, inspect the relevant code and
      preserve unrelated user changes.

      ## Working preferences

      - Explain the reason for a change briefly.
      - Prefer small, reversible changes.
      - Run appropriate validation after editing.
      - Keep credentials and other secrets out of repositories and logs.

      ## Working Agreement
      - I drive. Default to research, insight, and options — NOT edits.
      - Don't modify files or run state-changing commands unless I ask.
      - When I ask for research: gather freely, dig deep, present findings.
      - When I ask for a change: smallest change that does it; show me, don't sprawl.
    '';
  };
}
