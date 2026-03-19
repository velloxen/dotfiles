{
  pkgs,
  lib,
  config,
  ...
}:
{
  programs.starship.enable = true;
  programs.starship.settings =
    (lib.my.mergeTOML [
      ./nerd-font-symbols.toml
      ./gruvbox-rainbow.toml
      ./starship.toml
    ])
    // {
      palettes.base16 = with config.lib.stylix.colors.withHashtag; {
        # gruvbox-rainbow colors
        color_time_text = base05;
        color_devenv_text = base05;
        color_language_text = base05;
        color_git_text = base05;
        color_os_username_text = base05;
        color_directory_text = base05;
        color_time = base01;
        color_devenv = base02;
        color_language = blue;
        color_git = cyan;
        color_os_username = orange;
        color_directory = yellow;
        color_success = green;
        color_replace_symbol = magenta;
        color_error = red;
      };
    };
}
