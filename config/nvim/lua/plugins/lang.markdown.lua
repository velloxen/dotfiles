return {
    { "LazyVim/LazyVim", import = "lazyvim.plugins.extras.lang.markdown" },
    { "stevearc/conform.nvim" },
    { "nvimtools/none-ls.nvim" },
    { "mfussenegger/nvim-lint" },

    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            vim.list_extend(opts.ensure_installed, {
                "markdown",
                "markdown_inline",
            })
        end,
    },
}
