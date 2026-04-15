# Nix-based Dotfiles

This is my managing of dotfiles and other configurations based with Nix.

To update things, use the following from this `/etc/nix-darwin` directory:

```bash
darwin-rebuild build --flake .#Borealis
```

## Structure

`aesthetics` carries aesthetic stuff: wallpapers, colorschemes, etc.

`config` is directly linked to `~/.config` and is the dotfiles.

`pkgs` carries a number of additional packages not in the `nixpkgs`. This is used,
e.g., to add some python programs.

`nixpkgs.nix` is `import`-able for defaulting as `pkgs`:

```nix
{ pkgs ? (import ./path/to/nixpkgs.nix) {}, ... }:
# ...
```

`overlays/default.nix` handles some common overlays --- extensions/modifications
to `nixpkgs`, including to `lib` and `pkgs`.

### `flake.nix`

```
# homeManagerConfiguration is ultimately running
# nixpkgs.lib.evalModules {
#   modules = modules;
#   specialArgs = extraSpecialArgs;
# }
# well, with home-manager sprinkles all over that
# # https://nixos.org/manual/nixpkgs/stable/#module-system
```

## Colors

### Stylix

I am using [Stylix](https://github.com/nix-community/stylix/tree/master) for
managing colors across applications. One slight problem is that you can't have the
normal default config file in use because of some collision with how Stylix
adds the colors (see [known issues](#known-issues)). Instead, use

```nix
programs.<program>.extraConfig = builtins.readFile <config file path>;
```

As a matter of standard, I prepend these file names with `hm-init.`. So, for
Wezterm, I use

```nix
programs.wezterm.extraConfig = builtins.readFile ./hm-init.wezterm.lua;
```

### Color Scripts

Color scripts are avilable under `./aesthetics/eyecandy/`. One particularly useful
one is `blocks` which simply displays 4-bit ANSI in a predictable order.

```bash
Plain:   black red green yellow blue magenta cyan white
Brights:   -    -     -     -     -     -      -    -
```

### Swamp

| Wezterm Role  | Hex     | HSL                    | Origin            |
|---------------|---------|------------------------|-------------------|
| Foreground    | #ebe0bb | hsl(39,  88.8%, 45.5%) | base06            |
| Background    | #242015 | hsl(40,  33.8%, 73.3%) |            base00 |
| Active FG     | #242015 | hsl(40,  33.8%, 73.3%) | base00            |
| Active BG     | #db930d | hsl(39,  88.8%, 45.5%) | base0c            |
| Inactive FG   | #d2c3a4 | hsl(40,  33.8%, 73.3%) | base05            |
| Inactive BG   | #3a3124 | hsl(35,  23.4%, 18.4%) |            base01 |
| Cursor FG     | #211d13 | hsl(43,  26.9%, 10.2%) | ANSI 00           |
| Cursor BG     | #b8a58C | hsl(34,  23.7%, 63.5%) |            base04 |
| Cursor Border | #d2c3a4 | hsl(40,  33.8%, 73.3%) | base05            |
| Selection FG  | #3a3124 | hsl(35,  23.4%, 18.4%) | base01            |
| Selection BG  | #d2c3a4 | hsl(40,  33.8%, 73.3%) | base05            |
| ANSI 00       | #211d13 | hsl(43,  26.9%, 10.2%) |                   |
| Bright 08     | #ebe0bb | hsl(46,  54.5%, 82.7%) |            base06 |
| ANSI 01       | #a82d56 | hsl(340, 57.7%, 41.8%) |            base0a |
| Bright 09     | #96294d | hsl(340, 57.1%, 37.5%) | darkened   base0a |
| ANSI 02       | #7a7653 | hsl(54,  19.0%, 40.2%) |            base0b |
| Bright 10     | #736f4e | hsl(54,  19.2%, 37.8%) | darkened   base0b |
| ANSI 03       | #db930d | hsl(39,  88.8%, 45.5%) |            base0c |
| Bright 11     | #e69a0e | hsl(39,  88.5%, 47.8%) | darkened   base0c |
| ANSI 04       | #91506c | hsl(334, 28.9%, 44.1%) |            base0e |
| Bright 12     | #80465f | hsl(334, 29.3%, 38.8%) | darkened   base0e |
| ANSI 05       | #c1666b | hsl(357, 42.3%, 57.8%) |            base0d |
| Bright 13     | #b05d61 | hsl(357, 34.4%, 52.7%) | darkened   base0d |
| ANSI 06       | #508991 | hsl(187, 28.9%, 44.1%) | lightened  base0f |
| Bright 14     | #61a0a8 | hsl(187, 29.0%, 52.0%) |            base0f |
| ANSI 07       | #d2c3a4 | hsl(40,  33.8%, 73.3%) |            base05 |
| Bright 15     | #d2c3a4 | hsl(40,  33.8%, 73.3%) |            base05 |

This is 8 functional + 8 highlights

| Neovim Role | Hex     | HSL                    | Notes            |
|-------------|---------|------------------------|------------------|
| base00      | #242015 | hsl(44,  26.3%, 11.2%) | BG               |
| base01      | #3A3124 | hsl(35,  23.4%, 18.4%) | BG2              |
| base02      | #4D3F32 | hsl(29,  21.3%, 24.9%) | BG3              |
| base03      | #5F4E41 | hsl(26,  18.8%, 31.4%) | Comments         |
| base04      | #B8A58C | hsl(34,  23.7%, 63.5%) | *                |
| base05      | #D2C3A4 | hsl(40,  33.8%, 73.3%) | FG               |
| base06      | #EBE0BB | hsl(46,  54.5%, 82.7%) |                  |
| base07      | #F1E9D0 | hsl(45,  54.1%, 88.0%) |                  |
| base08      | #DB930D | hsl(39,  88.8%, 45.5%) | Variables        |
| base09      | #EBE0BB | hsl(46,  54.5%, 82.7%) | numbers = base06 |
| base0A      | #A82D56 | hsl(340, 57.7%, 41.8%) | Classes          |
| base0B      | #7A7653 | hsl(54,  19.0%, 40.2%) | Strings          |
| base0C      | #DB930D | hsl(39,  88.8%, 45.5%) | Support = base08 |
| base0D      | #C1666B | hsl(357, 42.3%, 57.8%) | Functions        |
| base0E      | #91506C | hsl(334, 28.9%, 44.1%) | Keywords         |
| base0F      | #61A0A8 | hsl(187, 29.0%, 52.0%) | Parentheses      |

| Nam's Color Schema | Value   | Notes                       |
|--------------------|---------|-----------------------------|
| Name               | Swamp   |                             |
| Wallpaper          | .jpg    |                             |
| Neofetchpic        | .png    |                             |
| Foreground         | #ebe0bb |                             |
| CursorColor        | #b8a58c |                             |
| Background         | #242015 |                             |
| Background 2       | #3a3124 | More Background             |
| Background 3       | #4d3f32 | Split lines and frame lines |
| Contrast           | #d2c3a4 |                             |
| Cursorline         | #d2c3a4 |                             |
| Comment            | #5f4e41 |                             |
| Darker             | #211d13 |                             |
| Lighter            | #f1e9d0 |                             |
| Color 00           | #242015 | Black                       |
| Color 08           | #3a3124 |                             |
| Color 01           | #a82d56 | Red                         |
| Color 09           | #96294d |                             |
| Color 02           | #7a7653 | Green                       |
| Color 10           | #736f4e |                             |
| Color 03           | #db930d | Yellow                      |
| Color 11           | #e69a0e |                             |
| Color 04           | #91506c | Blue                        |
| Color 12           | #80465f |                             |
| Color 05           | #c1666b | Magenta                     |
| Color 13           | #b05d61 |                             |
| Color 06           | #508991 | Cyan/Teal                   |
| Color 14           | #61a0a8 |                             |
| Color 07           | #b8a58c | White                       |
| Color 15           | #d2c3a4 |                             |

Swamp colors:

| Light Hex | Dark Hex  | Note                 |
|-----------|-----------|----------------------|
| #1d2021   | #211d13   | DarkHard             |
| #282828   | #242015   | Dark1 / BG           |
| #3c3836   | #3a3124   | Dark2                |
| #504945   | #4d3f32   | Dark3                |
| #665c54   | #5f4e41   | Dark4                |
| #7c6f64   | #725c4f   | Dark5                |
| #928374   | #856a5d   | Dark6 / DarkGrey     |
| #a89984   | #9f8875   | Light5 / LightGrey   |
| #bdae93   | #b8a58c   | Light4               |
| #d5c4a1   | #d2c3a4   | Light3               |
| #ebdbb2   | #ebe0bb   | Light2 / FG          |
| #fbf1c7   | #f1e9d0   | Light1               |
| #d65d0e   | #b06733   | DarkOrange           |
| #fe8019   | #ba6d36   | Orange               |
| #d79921   | #db930d   | DarkYellow           |
| #fabd2f   | #e69a0e   | Yellow               |
| #458588   | #91506c   | DarkBlue             |
| #83a598   | #80465f   | Blue                 |
| #98971a   | #7a7653   | DarkGreen            |
| #b8bb26   | #736f4e   | Green                |
| #b16286   | #c1666b   | DarkMagenta          |
| #d3869b   | #b05d61   | Magenta              |
| #cc241d   | #96294d   | DarkRed              |
| #fb4934   | #a82d56   | Red                  |
| #689d6a   | #508991   | DarkCyan             |
| #8ec07c   | #61a0a8   | Cyan                 |

## On Applications

I think this is what's going on with Applications: First, [Nix-Darwin](https://github.com/grepgrok/darwin)
sets up the system. Among this is creating (empty) things (files or directories)
in `/run/current-system/sw -> /nix/store/[hash]-system-path` (creates in `...system-path`
and links `...sw -> ...sysem-path`) based on `environment.pathsToLink`. Now then,
Home-Manager downloads the file in the nix store (with the crazy hash
`nix/store/[hash]-home-manager-path/...`; see `home.packages`). Home-Manager then
links the `/run/current-system/sw/...` file structure (the `...`) to
`/nix/store/[hash]-user-environment/... <- /etc/static/profiles/per-user/$USER
<- /etc/profiles/per-user/$USER`. Finally, things get linked appropriately in
`/Users/$USER`. Importantly for us here, we get
`/Users/$USER/Applications/Home\ Manager\ Apps` (which are actually directly
linked to the original files in the nix store).

## Tips and Tricks

You can use `lib.mapAttrsRecursive (_: lib.mkForce) attrset` to apply `mkForce`
to the *leaves* of `attrset`. This is particularly useful when overriding a large
number of individual options without having to use `mkForce` on each and every
option; common in hand-resolving colors.

## Known Issues

### Stylix and config files

Many (all?) [Stylix](#stylix) color configurations involve writing to "main config"
files. For example, Stylix tries to write

```nix
xdg.configFile."wezterm/wezterm.lua".text = ...;
```

This conflicts (silently) with the way I include the config files:

```nix
home.file.".config" = { source = ./config; recursive = true; };
```

Typically, Home Manager's activation script with `home.file` catches conflicting
targets --- both for pre-existing files (which it just overwrites) and explicit:

```nix
home.file = {
    conflict1 = { text = "foo"; target = "baz"; };
    conflict2 = { text = "bar"; target = "baz"; };
}
```

As noted [above](#stylix), the most straightforward way to handle this nicely
while still being able to use the normal config file is to include it via
`extraConfig`. For example, with Wezterm,

```nix
programs.wezterm.extraConfig = builtins.readFile hm-init.wezterm.lua;
```

As a standard, I prepend these configs with `hm-init.`.

## TODO

- make usre nvim docs are downloaded?
- make `./config/nvim/lua/config/lazy.lua` downloading LazyVim more Nix-like
- appropriate modules across hosts and user profiles
- update READMEs
- use some `requirements.txt` or `setup.py` instead of manually adding
    the packages in `pkgs`
- [steam](https://wiki.nixos.org/wiki/Steam)
- [obsidian](https://nix-community.github.io/home-manager/options.xhtml#opt-programs.obsidian.enable)
  - should just look into switching to [neorg](https://github.com/nvim-neorg/neorg)
- [chrome](https://unix.stackexchange.com/questions/429765/howto-install-google-chrome-in-nixos)
  - for when firefox doesn't work. mostly for [asbplayer](https://docs.asbplayer.dev/docs/intro)
  - sort out browser extensions
- [1password](https://wiki.nixos.org/wiki/1Password)
- [brother iprint and scan](https://nixos.wiki/wiki/Scanners#Brother)
- [TagStudio](https://github.com/TagStudioDev/TagStudiohttps://github.com/TagStudioDev/TagStudio)
- tests
- Tor
- electric sheep
- wallpaper sizer
- clear out unused applications
- finder open text files with nvim
- handle more apps. many should be deleted. Or moved to some workspace so they
    are only installed when I want
  - Blender
  - gimp & inkscape
  - unity
  - audacity
  - praat
- [discord](https://wiki.nixos.org/wiki/Discord)
  - infinite updating problem
  - get discord in bar to follow current version
  - some setting about following keystrokes?
- style:
  - zotero
  - zoom-us
  - [firefox](https://nix-community.github.io/home-manager/options.xhtml#opt-programs.firefox.enable)
    - sort out browser extensions
    - `warning: stylix: firefox:`config.stylix.targets.firefox.profileNames`is
        not set. Declare profile names with
        'config.stylix.targets.firefox.profileNames = [ "<PROFILE_NAME>" ];'.`
  - [spotify](https://nixos.wiki/wiki/Spotify)
- sort out spotify firewall ports thing in nix-darwin
- Neorg Keybinds ~
  - Neorg is configured to use keybind preset `neorg`
  - ⚠️ WARNING Key `<` conflicts with a key bound by the user. Neorg will not
  bind this key.
    - ADVICE:
      - consider mapping `<Plug>(neorg.promo.demote.range)` to a different key
      than the one bound by Neorg.
  - ⚠️ WARNING Key `>` conflicts with a key bound by the user. Neorg will not
  bind this key.
    - ADVICE:
      - consider mapping `<Plug>(neorg.promo.promote.range)` to a different key
      than the one bound by Neorg.
  - ⚠️ WARNING Key `gO` conflicts with a key bound by the user. Neorg will not
  bind this key.
    - ADVICE:
      - consider mapping `<cmd>Neorg toc<CR>` to a different key than the one
      bound by Neorg.
- unknown:
  - notability
  - signal
    - `signal-desktop`?
    - this should only build for things it is available for. Otherwise, only if
        not already installed, warn it wasn't included and say where to get it
  - authy
    - honestly, just start converting things to 1password
