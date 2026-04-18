return {
  "L3MON4D3/LuaSnip",
  event = { "InsertEnter" },
  config = function()
    local ls = require("luasnip")
    local types = require("luasnip.util.types")

    ls.setup({
      history = true,
      delete_check_events = "TextChanged",
      enable_autosnippets = true,
    })

    require("luasnip.loaders.from_lua").lazy_load({ paths = { vim.fn.stdpath("config") .. "/lua/snippets" } })

    -- <c-l> is selecting within a list of options.
    vim.keymap.set({ "s", "i" }, "<D-L>", function()
      if ls.choice_active() then
        ls.change_choice(1)
      end
    end, { desc = "Scroll through choice nodes" })

    -- <c-k> is my expansion key
    -- this will expand the current item or jump to the next item within the snippet.
    vim.keymap.set({ "i", "s" }, "<D-K>", function()
      if ls.expand_or_jumpable() then
        ls.expand_or_jump()
      end
    end, { silent = false, remap = true })

    -- <c-j> is my jump backwards key.
    -- this always moves to the previous item within the snippet
    vim.keymap.set({ "i", "s" }, "<D-J>", function()
      if ls.jumpable(-1) then
        ls.jump(-1)
      end
    end, { silent = true })
  end,
}
