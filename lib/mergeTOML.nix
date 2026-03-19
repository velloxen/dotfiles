{ lib, ... }:
let
  inherit (lib)
    pipe
    importTOML
    mergeAttrsList
    ;
  inherit (builtins) map;
in
# fnames :: [ Path ] -> Attrs
# Attrs are selected with later precedenc via `//`: in case of duplicate
# attributes, those defined in the latest TOML are selected.
fnames:
pipe fnames [
  (map importTOML)
  mergeAttrsList
]
