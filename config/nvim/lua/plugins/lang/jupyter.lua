return {
  -- dependencies = { "plugins.lang.python" },
  {
    "hkupty/iron.nvim",
    config = function()
      local iron = require("iron.core")

      iron.setup({
        config = {
          should_map_plug = false,
          -- Whether a repl should be discarded or not
          scratch_repl = true,
          repl_definition = {
            python = {
              command = { "python3" },
              format = require("iron.fts.common").bracketed_paste_python,
              env = { PYTHON_BASIC_REPL = "1" }, -- required for python3.13+
            },
          },
          repl_open_cmd = require("iron.view").split.vertical.botright(40),
        },
        keymaps = {
          send_motion = "<space>rc",
          visual_send = "<space>rc",
        },
      })

      vim.keymap.set("n", "]x", "<space>rcih/^# %%<CR><CR>", { desc = "Send cell to IronRepl and move to next cell" })
    end,
  },

  {
    "goerz/jupytext.nvim",
    opts = {
      format = "py:hydrogen",
    },
  }, -- May need GCBallesteros/jupytext.vim instead

  -- Neovim Text Objects
  { "kana/vim-textobj-user" },
  { "GCBallesteros/vim-textobj-hydrogen", dependencies = { "kana/vim-textobj-user" } }, -- ih/ah [hydrogen style](https://github.com/nteract/hydrogen) code cells `#%%`
}
