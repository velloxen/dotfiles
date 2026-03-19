# TODO: better name
# src --- the file the do substitutions on
# replacements --- attrset of prefixes and matching attrsets effectively a conflation between
#                   things following the prefix and the attrs of the attrset
#                   e.g. replacements = { "p." = { a = "hello"; b = "world"; } }
#                   (note the dot in the prefix) will replace all instances of `p.a` with `"hello"`
#                   and `p.b` with `"world"` (assuming `wrap = true`).
#                   Note that these are checked and only checked for string coersion-ability.
# wrap --- whether or not to wrap the replacing string with `wrapWith`
#           default: true
# wrapWith --- attrset { left = ...; right = ...; }
#               left and right wrapping items
#               default: { left = "\"""; right = "\""; }
# returns:
#  path to modified file
{ pkgs, lib }:
{
  src,
  replacements,
  wrap ? true,
  wrapWith ? {
    left = "\"";
    right = "\"";
  },
  ...
}@args:
let
  inherit (builtins)
    attrNames
    attrValues
    isString
    getAttr
    mapAttrs
    ;
  inherit (lib)
    flatten
    foldl
    pipe
    ;
  get_substitution' =
    attrs: prefix: acc: attr:
    if !(isString (getAttr attr attrs)) then
      acc
    else
      acc
      ++ [
        "--replace-quiet"
        (prefix + attr)
        (if wrap then wrapWith.left + getAttr attr attrs + wrapWith.right else getAttr attr attrs)
      ];
  # prefix --- prefix for replacements
  # attrs  --- the attribute set to replace through
  # wrap   --- whether or not to wrap the text with quotes
  replace' =
    wrap: wrapWith: prefix: attrs:
    foldl (get_substitution' attrs prefix) [ ] (attrNames attrs);
in
# https://nixos.org/manual/nixpkgs/stable/#pkgs-substitute
pkgs.substitute {
  inherit src;
  substitutions = pipe replacements [
    (mapAttrs (replace' wrap wrapWith))
    attrValues
    flatten
  ];
}
// args
