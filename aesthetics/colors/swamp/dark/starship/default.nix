{
  lib,
  config,
  ...
}:
with config.lib.stylix.colors.withHashtag;
{
  programs.starship.settings.palettes.base16 = lib.mapAttrsRecursive (_: lib.mkForce) {
    # gruvbox-raindbow
    color_os_username_text = base01;
    color_git_text = base01;
  };
}
