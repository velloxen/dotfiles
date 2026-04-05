return {
    "lervag/vimtex",
    config = function()
        vim.g.vimtex_view_method = "zathura_simple"
        vim.g.vimtex_view_zathura_use_synctex = 0
        vim.g.vimtex_compiler_latexmk_engines = { _ = "-lualatex" }
    end,

    -- TODO: the `' tex quote problem is a vimtex problem
    -- check on texLigature
    -- maybe make `' a buffer mapping in mini.pairs
    -- config = function()
    --     vim.g.vimtex_view_method = "zathura"

    --     -- if vim.fn.has("macunix") then
    --     --     vim.g.vimtex_view_method = "skim"
    --     -- else
    --     --     vim.g.vimtex_view_method = "zathura"
    --     -- end

    --     vim.g.vimtex_compiler_latexmk_engines = { _ = "-lualatex" }
    -- end,
}
