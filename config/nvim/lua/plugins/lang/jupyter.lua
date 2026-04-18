local function tobj(to)
  if to.dependencies == nil then
    to.dependencies = {}
  end
  table.insert(to.dependencies, "kana/vim-textobj-user")
end

return {
  -- dependencies = { "plugins.lang.python" },
  {
    "hkupty/iron.nvim",
    config = function()
      local iron = require("iron.core")

      iron.setup({
        config = {
          -- Whether a repl should be discarded or not
          scratch_repl = true,
          repl_definition = {
            sh = {
              -- Can be a table or a function that
              -- returns a table (see below)
              command = { "zsh" },
            },
          },
          -- How the repl window will be displayed
          -- See below for more information
          repl_open_cmd = require("iron.view").bottom(40),
        },
        keymaps = {
          send_motion = "ctr",
          visual_send = "ctr",
        },
      })

      -- iron also has a list of commands, see :h iron-commands for all available commands
      vim.keymap.set("n", "<space>rs", "<cmd>IronRepl<cr>")
      vim.keymap.set("n", "<space>rr", "<cmd>IronRestart<cr>")
      vim.keymap.set("n", "<space>rf", "<cmd>IronFocus<cr>")
      vim.keymap.set("n", "<space>rh", "<cmd>IronHide<cr>")
    end,
  },

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
