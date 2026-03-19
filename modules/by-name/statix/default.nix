{lib, config, pkgs, ...}:
{
    options.devenv.statix.enable = lib.mkEnableOption "statix";
    config = {
        home.packages = [ pkgs.statix ];
    };
}
