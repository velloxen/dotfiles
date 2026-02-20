{ }:
[
    # Additions
    (final: _prev: import ../pkgs { pkgs = final; })

    # Stable
    # This *should* make pkgs.stable be from nixpkgs-stable, but it doesn't work.
    # It keeps fucking up with trying to pull like this
    # (final: _prev: { stable = import inputs.nixpkgs-stable { inherit (final) system config; }; })
]
