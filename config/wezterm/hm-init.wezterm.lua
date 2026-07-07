local wezterm = require("wezterm")
local config = {}
config.default_prog = { "zsh" }
config.scrollback_lines = 1024
config.warn_about_missing_glyphs = true
config.window_close_confirmation = "NeverPrompt"
config.check_for_updates = false

------ Appearance -----
local padding = {
  left = 15,
  right = 15,
  top = 15,
  bottom = 15,
}
config.window_padding = padding

-- Handle NeoVim padding
wezterm.on("user-var-changed", function(window, pane, name, value)
  if name == "NVIM_ENTER" then
    local overrides = window:get_config_overrides() or {}
    if value == "1" then
      overrides.window_padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0,
      }
    else
      overrides.window_padding = padding
    end
    window:set_config_overrides(overrides)
  end
end)

config.window_background_opacity = 0.9
config.inactive_pane_hsb = {
  saturation = 1.0,
  brightness = 0.8,
}

config.default_cursor_style = "SteadyUnderline"
config.enable_scroll_bar = false

-- Tab Bar
config.use_fancy_tab_bar = false
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.show_tab_index_in_tab_bar = false

-- Font
config.font_size = 16.0
config.cell_width = 1
config.line_height = 1.15
config.dpi = 96.0
config.font = wezterm.font_with_fallback({
  "0xProto Nerd Font Propo",
  "Material Design Icons",
})
config.font_rules = {
  {
    italic = true,
    font = wezterm.font("0xProto Nerd Font Propo", { italic = true }),
  },
}
config.harfbuzz_features = { "calt=1", "clig=1", "liga=1" } -- font shaping; only when font_shaper = "Harfbuzz"

-- Colors
config.bold_brightens_ansi_colors = true
-- config.color_scheme = "followSystem"

----- Technical Details -----
-- TODO: os dependent; if mac then WebGpu else OpenGL
config.front_end = "WebGpu" -- WebGpu allows using Metal for Mac
config.enable_wayland = true -- no effect on Mac

return config
