{
  description = "Flake Template for nix develop";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        # devShells.[name] means you can use nix develop /path/to/this/flake#[name]
        # usually just nix develop (for default) or nix develop .#[name]
        devShells.default = pkgs.mkShell {
          name = "<name>";

          packages = with pkgs; [ ];

          # Bash code run on shell entry
          shellHook = /* bash */ ''
            exec zsh
          '';
        };
      }
    );
}
