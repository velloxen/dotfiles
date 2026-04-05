{
  pkgs,
  lib,
  config,
  ...
}:
{
  config = lib.mkIf config.programs.git.enable {
    programs.git.settings = {
      user.name = "velloxen";
      user.email = "velloxen@gmail.com";
      credential.helper = lib.mkIf (pkgs.stdenv.hostPlatform.system == "aarch64-darwin") "osxkeychain";
      init.defaultBranch = "main";
    };
    programs.git.signing.format = null;
  };
}
