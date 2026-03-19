{
  pkgs ? (import ../nixpkgs.nix) { },
}:
{
  subs2cia = pkgs.callPackage ./subs2cia.nix {
    inherit (pkgs.python3Packages) buildPythonPackage;
  };
}
