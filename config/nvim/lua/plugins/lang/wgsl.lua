return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = { ensure_installed = { "wgsl" } },
    },

    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                wgsl_analyzer = {
                    on_attach = function(_, bufnr)
                        vim.lsp.inlay_hint.enable(true, { bufnr, bufnr })
                    end,
                },
            },
        },
    },
}
