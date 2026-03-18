return {
    { "LazyVim/LazyVim", import = "lazyvim.plugins.extras.lang.rust" },

    --- Ensure Optionals
    { "mason-org/mason.nvim" },
    { "nvim-neotest/neotest" },

    --- Ensure Treesitter support
    {
        "nvim-treesitter/nvim-treesitter",
        -- TODO: can this be just a dictionary, not a functions?
        opts = function(_, opts)
            vim.list_extend(opts.ensure_installed, {
                "rust",
            })
        end,
    },
}
