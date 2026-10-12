{lib, ...}: {
  # inspiron specific secrets separate from the general "secrets.nix" file
  security.nix-secrets.secrets = {
    copyparty-zx = {
      recipients = ["master"];
      owner = "copyparty";
      group = "copyparty";
      mode = "0400";
    };

    copyparty-smarties = {
      recipients = ["master"];
      owner = "copyparty";
      group = "copyparty";
      mode = "0400";
    };

    slskd = {
      recipients = ["master"];
      owner = "slskd";
      group = "slskd";
      mode = "0400";
    };

    hermes-env = {
      recipients = ["master"];
      owner = "onoruu";
      group = "onoruu";
      mode = "0400";
    };

    # karakeep runs as its own system user and reads this as an environment file
    # default owner and 0600 user permissions dont work for this
    openai-opencode = {
      owner = lib.mkForce "karakeep";
      group = lib.mkForce "karakeep";
      mode = lib.mkForce "0600";
    };
  };
}
