local function tobj(to)
  if to.dependencies == nil then
    to.dependencies = {}
  end
  table.insert(to.dependencies, "kana/vim-textobj-user")
end

return {
  -- TODO: Ensure python.lua is enabled
  { "hkupty/iron.nvim" },
  {
    "goerz/jupytext.nvim",
    opts = {
      format = "py:hydrogen",
    },
  }, -- May need GCBallesteros/jupytext.vim instead

  -- Neovim Text Objects
  tobj({ "kana/vim-textobj-line" }), -- il/al current line
  tobj({ "GCBallesteros/vim-textobj-hydrogen" }), -- ih/ah [hydrogen style](https://github.com/nteract/hydrogen) code cells `#%%`
}
