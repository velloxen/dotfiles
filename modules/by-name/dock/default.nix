# TODO: targets.darwin.defaults."com.apple.dock".autohide
{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [ ./dock ];

  options.services.dock.enable = lib.mkEnableOption "dock";

  # https://github.com/dustinlyons/nixos-config/blob/8a14e1f0da074b3f9060e8c822164d922bfeec29/modules/darwin/home-manager.nix#L74
  config = lib.mkIf config.services.dock.enable {
    my.dock = {
      inherit (config.home) username;
      enable = true;
      entries = [
        { path = "/Applications/Firefox.app/"; }
        { path = "/Applications/Spotify.app"; }
        { path = "/Applications/Discord.app/"; }
        { path = "/System/Applications/Messages.app/"; }
        { path = "/Applications/Signal.app/"; }
        (lib.mkIf config.programs.wezterm.enable { path = "${pkgs.wezterm}/Applications/Wezterm.app/"; }) # should be whatever is the current terminal
        { path = "/Applications/Anki.app/"; }
        { path = "/Applications/Obsidian.app/"; }
        { path = "/System/Applications/Notes.app/"; }
      ];
    };
  };
}
