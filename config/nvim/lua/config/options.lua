-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.tabstop = 4 -- number of spaces a <Tab> counts for
vim.opt.shiftwidth = 0 -- shiftwidth = tabstop; spaces for (auto)indent
vim.opt.expandtab = true -- insert spaces for <Tab>

vim.opt.wrap = true
vim.opt.linebreak = true -- break by word

vim.g.vimtex_view_method = "zathura_simple"
vim.g.vimtex_view_zathura_use_synctex = 0
vim.g.vimtex_compiler_latexmk_engines = { _ = "-lualatex" }

vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        --NVIM_ENTER=1
        vim.cmd([[call chansend(v:stderr, "\033]1337;SetUserVar=NVIM_ENTER=MQ==\007")]])
    end,
})
