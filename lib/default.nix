pkgs:
pkgs.lib.extend (
  final: prev:
  let
    lib = final;
  in
  {
    my = {
      replace = import ./replace.nix { inherit pkgs lib; };
      mergeTOML = import ./mergeTOML.nix { inherit lib; };
    };
  }
)
