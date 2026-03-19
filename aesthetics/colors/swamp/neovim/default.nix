{
  pkgs,
  lib,
  config,
  ...
}:
{
  programs.neovim.plugins = [
    {
      plugin = pkgs.vimPlugins.mini-nvim;
      type = "lua";
      config = lib.mkAfter (
        builtins.readFile (
          lib.my.replace {
            src = ./neovim.lua;
            replacements = {
              "palette." = config.lib.stylix.colors.withHashtag;
            };
          }
        )
      );
    }
  ];
}
