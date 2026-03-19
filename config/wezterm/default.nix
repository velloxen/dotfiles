{ pkgs, ... }:
{
  home.packages = [ pkgs.nerd-fonts._0xproto ];
  programs.wezterm = {
    enable = true;
    extraConfig = builtins.readFile ./hm-init.wezterm.lua;
  };
}
