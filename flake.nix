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

    outputs = {
        self,
        nixpkgs,
        nixpkgs-stable,
        home-manager,
        stylix,
        ...
    } @ inputs:
    let
        inherit (self) outputs;
        system = "aarch64-darwin";
        pkgs = nixpkgs.legacyPackages.${system};
        pkgs-stable = nixpkgs-stable.legacyPackages.${system};

        lib = import ./lib pkgs;
    in
    rec {
        # homeManagerConfiguration is ultimately running
        # nixpkgs.lib.evalModules {
        #   modules = modules;
        #   specialArgs = extraSpecialArgs;
        # }
        # well, with home-manager sprinkles all over that
        # # https://nixos.org/manual/nixpkgs/stable/#module-system
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
    };
}
