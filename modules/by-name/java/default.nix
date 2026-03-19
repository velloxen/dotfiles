{
  pkgs,
  config,
  lib,
  ...
}:
{
  config = lib.mkIf config.programs.java.enable {
    programs.java.package = pkgs.jre_minimal;
  };
}
