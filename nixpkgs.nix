# https://github.com/namishh/crystal/blob/cc37b56577e951b0c98c1a97840febdce1e39691/nixpkgs.nix
# A nixpkgs instance that is grabbed from the pinned nixpkgs commit in the lock file
# This is useful to avoid using channels when using legacy nix commands
let
  lock = (builtins.fromJSON (builtins.readFile ./flake.lock)).nodes.nixpkgs.locked;
in
import (fetchTarball {
  url = "https://github.com/nixos-unstable/nixpkgs/archive/${lock.rev}.tar.gz";
  sha256 = lock.narHash;
})
