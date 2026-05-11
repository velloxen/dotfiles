return {
  -- dependencies = { "plugins.lang.python" },
  {
    "hkupty/iron.nvim",
    enabled = false,
    config = function()
      local iron = require("iron.core") --

      iron.setup({
        config = {
          should_map_plug = false,
          -- Whether a repl should be discarded or not
          scratch_repl = true,
          repl_definition = {
            python = {
              command = { "ipython" },
              format = require("iron.fts.common").bracketed_paste_python,
              block_dividers = { "# %%", "#%%" },
              env = { PYTHON_BASIC_REPL = "1" }, -- required for python3.13+
            },
          },
          repl_open_cmd = require("iron.view").split.vertical.botright(80),
        },
        keymaps = {
          send_motion = "<space>rc",
          visual_send = "<space>rc",
          send_code_block_and_move = "]x",
        },
      })
    end,
  },

  {
    "goerz/jupytext.nvim",
    enabled = false,
    opts = {
      format = "py:hydrogen",
    },
  },

  -- Neovim Text Objects
  {
    "kana/vim-textobj-user",
    enabled = false,
  },
  {
    "GCBallesteros/vim-textobj-hydrogen",
    enabled = false,
    dependencies = { "kana/vim-textobj-user" },
  }, -- ih/ah [hydrogen style](https://github.com/nteract/hydrogen) code cells `#%%`
}
