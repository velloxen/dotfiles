# Basing after reckenrode's nixos-configs
# https://github.com/reckenrode/nixos-configs/blob/main/modules/top-level/all-modules.nix
# Currently just manually handling modules
{ ... }:
{
  imports = [
    # TODO: local keep-sorted/other linting/opinionated style
    ../by-name/git
    ../by-name/java
    ../by-name/tex
    ../by-name/nh
    ../by-name/nixfmt
    ../by-name/statix
    ../by-name/dock
    ../by-name/inkscape
  ];
}
