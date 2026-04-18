local ls = require("luasnip")
local utils = require("luasnip-latex-snippets.util.utils")
local pipe = utils.pipe
local is_math = utils.with_opts(utils.is_math, false)
local no_backslash = utils.no_backslash

local decorator = {
  wordTrig = false,
  condition = pipe({
    is_math,
    no_backslash,
  }),
  trigEngine = "vim",
  priority = 5000,
}

local s = ls.extend_decorator.apply(ls.snippet, decorator) --[[@as function]]
local f = ls.function_node
local t = ls.text_node

local GREEK =
  "alpha\\|beta\\|gamma\\|delta\\|epsilon\\|varepsilon\\|zeta\\|eta\\|theta\\|vartheta\\|iota\\|kappa\\|lambda\\|mu\\|nu\\|xi\\|pi\\|varpi\\|rho\\|varrho\\|sigma\\|varsigma\\|tau\\|upsilon\\|phi\\|varphi\\|chi\\|psi\\|omega\\|Gamma\\|Delta\\|Theta\\|Lambda\\|Xi\\|Pi\\|Sigma\\|Upsilon\\|Phi\\|Chi\\|Psi\\|Omega"

local TIGHTEN_ON = ",\\|\\\\)\\|\\\\]\\|)\\|\\^\\|("

-- First list: controlled snippets (show up as autocomplete options)
-- Second list: autosnippets
return {
  s({ trig = "@w", name = "omega" }, t("\\omega ")),
}, {
  s(
    -- \C explicitly tells vim to be case sensitive
    { trig = "\\C\\([NZQRSTKCF]\\)\\1", name = "math blackboard bold", priority = 4000 },
    f(function(_, snip)
      return "\\mathbb{" .. snip.captures[1] .. "}"
    end, {})
  ),
  s(
    { trig = "\\C\\([P]\\)\\1", name = "math caligraphic" },
    f(function(_, snip)
      return "\\mathcal{" .. snip.captures[1] .. "}"
    end, {})
  ),
  s(
    { trig = "\\\\mathbb{\\(.*\\)}\\1", name = "math blackboard bold -> caligraphic" },
    f(function(_, snip)
      return "\\mathcal{" .. snip.captures[1] .. "}"
    end, {})
  ),
  s(
    { trig = "\\\\mathcal{\\(.*\\)}\\1", name = "math caligraphic -> blackboard bold" },
    f(function(_, snip)
      return "\\mathbb{" .. snip.captures[1] .. "}"
    end, {})
  ),

  s({ trig = "cup", name = "set union" }, t("\\cup ")),
  s({ trig = "cap", name = "set intersection" }, t("\\cap ")),
  s({ trig = "eset", name = "e(mpty)set" }, t("\\emptyset ")),
  s({ trig = "00", name = "emptyset 00" }, t("\\emptyset ")),
  s({ trig = "\\%[ ]compl", name = "complement" }, t("^\\complement")),
  s(
    { trig = "\\(\\%[,]\\)\\.\\.\\.", name = "dots" },
    f(function(_, snip)
      local prefix = snip.captures[1] == "," and ", " or ""
      return prefix .. "\\dots "
    end, {})
  ),
  ls.snippet(
    {
      trig = string.format("\\C\\\\\\(%s\\|dots\\|emptyset\\) \\(%s\\)", GREEK, TIGHTEN_ON),
      trigEngine = "vim",
      wordTrig = false,
    },
    f(function(_, snip)
      return "\\" .. snip.captures[1] .. snip.captures[2]
    end, {})
  ),

  -- TODO: liminf -> \liminf NOT lim\inf
  --parse({ trig = "liminf", name = "liminf", priority = 0 }, "\\liminf_{${1:n} \\to ${2:\\infty}} "),
}
