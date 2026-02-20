{
    pkgs,
    pkgs-stable,
    lib,
    config,
    ...
}:
let
    cfg = config.programs.tex;
in
{
    options.programs.tex.enable = lib.mkEnableOption "tex";

    config = lib.mkIf cfg.enable {
        home.packages = with pkgs; [
            # lib.mkIf (!isMac) zathura
            skimpdf
            dbus
            pkgs-stable.texlive.combined.scheme-full # the actual texlive has a tendency to be unstable
        ];
    };
}
