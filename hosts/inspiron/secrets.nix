{
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
  };
}
