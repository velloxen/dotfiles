_: {
  config.stylix.enable = true;
  config.stylix.base16Scheme = ./swamp-dark.yaml;
  config.stylix.polarity = "dark";

  imports = [
    ../neovim
    ./starship
  ];
}
