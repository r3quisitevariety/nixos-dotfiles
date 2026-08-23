{
  inputs,
  user,
  pkgs,
  ...
}: {
  imports = [
    inputs.hermes-agent.nixosModules.default
  ];

  # allows user to cd into ~/.hermes
  # hermes automatically creates a containerized user called "hermes" when you enable the module
  users.users.${user} = {
    extraGroups = ["hermes"];
  };

  services.hermes-agent = {
    enable = true;
    # just keeping things explicit here; module does this by default
    user = "hermes";
    group = "hermes";
    createUser = true;
    # statedir is symlinked to ~/.hermes for some reason (even though im using the nixos module)
    stateDir = "/var/lib/hermes";
    # hermes somehow has access to all of /home/onoruu lol idk
    workingDirectory = "/var/lib/hermes/workspace";
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

    #TODO
    #mcpServers.

    # containers if you want them
    #container = {
    #  enable = true;
    #  backend = "docker";
    #  hostUsers = [user];
    #  # Add explicit host:container mounts here when Hermes needs access to
    #  # project directories outside /var/lib/hermes.
    #  # extraVolumes = [ "/home/onoruu/code:/projects:rw" ];
    #};

    # api keys, bot tokens, passwords
    # unlike home.file, this doesn't overwrite.
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
        mode = "smart";
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
    '';
  };
}
