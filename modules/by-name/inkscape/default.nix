# This conversion of a package into an enablable module is so simple and repetitive
# it should be reduced to a quick function.of just the package and config path
{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.programs.inkscape.enable = lib.mkEnableOption "inkscape";
  config = lib.mkIf config.programs.inkscape.enable {
    home.packages = [ pkgs.inkscape ];
  };
}
