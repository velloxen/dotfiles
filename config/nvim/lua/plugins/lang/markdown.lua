return {
  { "LazyVim/LazyVim", import = "lazyvim.plugins.extras.lang.markdown" },

  --- Optionals
  { "stevearc/conform.nvim" },
  -- { "nvimtools/none-ls.nvim" },
  { "mfussenegger/nvim-lint" },

  --- Ensure Treesitter support
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "markdown", "markdown_inline" } },
  },
}
