{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.devenv.nixfmt.enable = lib.mkEnableOption "nixfmt";
  config = {
    home.packages = [ pkgs.nixfmt ];
  };
}
