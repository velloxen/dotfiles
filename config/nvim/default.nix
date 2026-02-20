{ pkgs, lib, ... }:
let
    linterLanguages = packages: with packages; [
        c
        haskell
        json
        lua
        markdown
        markdown_inline
        nix
        rust
        toml
        yaml
    ];

    dependencies = with pkgs; [
        curl
        fd
        fzf
        git
        lazygit
        nerd-fonts._0xproto
        ripgrep

        (pkgs.vimPlugins.nvim-treesitter.withPlugins linterLanguages)
    ];
in
{
    home.packages = dependencies;
    ## Get LazyVim to work with Nix and home-manager
    # https://github.com/LazyVim/LazyVim/discussions/1972#discussion-5826338
    programs.neovim = {
        enable = true;
        extraPackages = with pkgs; [
            lua-language-server
            stylua
            ripgrep
            imagemagick # image.nvim
        ];

        extraLuaPackages = ps: with ps; [
            ps.magick # image.nvim
        ];

        plugins = with pkgs.vimPlugins; [
            lazy-nvim
        ];

        initLua = builtins.readFile ./hm-init.init.lua;
    };
}
