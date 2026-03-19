_: {
  config.stylix.enable = true;
  config.stylix.base16Scheme = ./swamp-light.yaml;
  config.stylix.polarity = "light";

  imports = [
    ../neovim
    ./starship
  ];
}
