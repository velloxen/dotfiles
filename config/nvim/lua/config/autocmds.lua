-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
-- Commands when Vim start

vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    --NVIM_ENTER=0
    vim.cmd([[call chansend(v:stderr, "\033]1337;SetUserVar=NVIM_ENTER=MA==\007")]])
  end,
})
