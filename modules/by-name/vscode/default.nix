{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.programs.vscode;
in
{
  config = lib.mkIf cfg.enable {
    #programs.vscode.profiles."ben" = { extensions = with pkgs.vscode-extensions; [ ]; };
  };
}
