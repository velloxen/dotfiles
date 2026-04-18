return {
  "rickhowe/wrapwidth",
  enabled = false,
  init = function()
    -- vim.g.wrapwidth_sign = "↵"
    -- vim.g.wrapwidth_number = 1
    -- vim.g.statuscolumn="%{v:virtnum == 0 ? v:lnum : -(v:virtnum + 1)}"

    -- TODO: Only for filetypes of interest
    vim.api.nvim_create_autocmd("BufEnter", {
      callback = function()
        vim.cmd("Wrapwidth 80")
      end,
    })
  end,
}
