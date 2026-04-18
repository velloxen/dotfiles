return {
  "jalvesaq/zotcite",
  -- TODO: for some reason, zotcite breaks autosnippets
  enabled = false,
  --dependencies = {
  --"nvim-treesitter/nvim-treesitter",
  --"nvim-telescope/telescope.nvim",
  --},
  -- TODO: Add menu title under [leader]
  config = function()
    require("zotcite").setup({
      key_type = "better-bibtex",
    })
  end,
}
