{ lib, config, ... }:
{
  config = lib.mkIf config.programs.nh.enable {
    programs.nh = {
      clean.enable = true;
      clean.extraArgs = "--keep-since 1w --keep 3";
    };
  };
}
