{
  inputs,
  ...
}: {
  imports = [
    inputs.nixcord.homeModules.nixcord
  ];

  programs.nixcord = {
    enable = true;

    # Equicord is a Vencord fork; required for the questify plugin.
    discord.equicord.enable = true;

    config.plugins.questify.enable = true;
  };
}
