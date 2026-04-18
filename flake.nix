{
  description = "Borealis nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/release-25.11"; # texlive has a tendency to get unstable

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:nix-community/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-stable,
      home-manager,
      stylix,
      ...
    }:
    let
      system = "aarch64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-stable = nixpkgs-stable.legacyPackages.${system};

      lib = import ./lib pkgs;
    in
    {
      homeConfigurations."ben" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs lib;

        modules = [
          stylix.homeModules.stylix
          ./home.nix
        ];
        # https://nixos.org/manual/nixpkgs/stable/#module-system-lib-evalModules-param-specialArgs
        extraSpecialArgs = {
          inherit
            # inputs
            pkgs-stable
            ;
        };
      };

      devShells.${system}.default =
        let
          name = ".nix";
        in
        pkgs.mkShell {
          inherit name;

          packages = with pkgs; [
            nil
            # (lua5_4.withPackages (
            #   ps: with ps; [
            #     luacheck
            #   ]
            # ))
          ];

          shellHook = /* bash */ ''
            echo "Entering ${name} devenv"
            echo "Type \`exit\` to return"
            trap "echo 'Exiting ${name} devenv'" EXIT
            exec zsh
          '';
        };
    };
}
