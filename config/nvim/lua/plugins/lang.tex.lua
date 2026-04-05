return {
    { "LazyVim/LazyVim", import = "lazyvim.plugins.extras.lang.tex" },

    --- Optionals
    { "neovim/nvim-lspconfig" },

    --- Ensure Treesitter support
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            vim.list_extend(opts.ensure_installed, {
                "bibtex",
                "latex",
            })
        end,
    },
}
