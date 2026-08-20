{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}; [
    hermes-agent
  ];
}
