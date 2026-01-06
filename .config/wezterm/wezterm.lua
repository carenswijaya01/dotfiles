local wezterm = require 'wezterm'

return {
  -- Shell
  default_prog = { "/usr/bin/zsh" },

  -- TERM
  term = "xterm-256color",

  -- Font
  font = wezterm.font_with_fallback({
    {
      family = "FiraCode Nerd Font Mono",
      weight = "Medium",
    },
  }),
  font_size = 11.0,

  -- Bold / Italic handling
  font_rules = {
    {
      intensity = "Bold",
      font = wezterm.font({
        family = "FiraCode Nerd Font Mono",
        weight = "Bold",
      }),
    },
    {
      intensity = "Bold",
      italic = true,
      font = wezterm.font({
        family = "FiraCode Nerd Font Mono",
        weight = "Bold",
        style = "Italic",
      }),
    },
    {
      italic = true,
      intensity = "Normal",
      font = wezterm.font({
        family = "FiraCode Nerd Font Mono",
        style = "Italic",
      }),
    },
  },

  -- Colors
  colors = {
    foreground = "#b2bbcc",
    background = "#1f2329",

    cursor_bg = "#b2bbcc",
    cursor_border = "#b2bbcc",
    cursor_fg = "#1f2329",

    selection_bg = "#535965",
    selection_fg = "#b2bbcc",

    ansi = {
      "#0e1013", -- black
      "#e55561", -- red
      "#8ebd6b", -- green
      "#e2b86b", -- yellow
      "#4fa6ed", -- blue
      "#bf68d9", -- magenta
      "#48b0bd", -- cyan
      "#b2bbcc", -- white
    },
    brights = {
      "#535965", -- bright black
      "#e55561", -- bright red
      "#8ebd6b", -- bright green
      "#e2b86b", -- bright yellow
      "#4fa6ed", -- bright blue
      "#bf68d9", -- bright magenta
      "#48b0bd", -- bright cyan
      "#b2bbcc", -- bright white
    },
  },

  -- Cursor
  default_cursor_style = "BlinkingBlock",
  cursor_blink_rate = 550,
  cursor_blink_ease_in = "Constant",
  cursor_blink_ease_out = "Constant",

  -- Scrollback
  scrollback_lines = 3000,

  -- Window
  window_padding = {
    left = 10,
    right = 10,
    top = 10,
    bottom = 10,
  },

  window_background_opacity = 1.0,
  enable_tab_bar = true,
  use_fancy_tab_bar = true,
  automatically_reload_config = true,

  -- Title
  window_close_confirmation = "NeverPrompt",

  -- Other
  -- hide_tab_bar_if_only_one_tab = true,
  front_end = "WebGpu",
  enable_wayland = true,
}
