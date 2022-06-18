local wezterm = require 'wezterm'

local scheme = wezterm.get_builtin_color_schemes()["OneHalfDark"]
scheme.scrollbar_thumb = "#353b45"

return {
  font = wezterm.font("JetBrainsMono Nerd Font"),
  font_size = 10.5,

  hide_tab_bar_if_only_one_tab = true,
  use_fancy_tab_bar = false,

  colors = {
    scrollbar_thumb = "#61afef",

    tab_bar = {
      background = "#1e222a",


      active_tab = {
	bg_color = "#353b45",
	fg_color = "#c8ccd4",
      },

      inactive_tab = {
	bg_color = "#282c34",
	fg_color = "#abb2bf",
      },

      inactive_tab_hover = {
	bg_color = "#61afef",
	fg_color = "#282c34",
      },

      new_tab = {
	bg_color = "#282c34",
	fg_color = "#61afef",
      },

      new_tab_hover = {
	bg_color = "#61afef",
	fg_color = "#282c34",
      },
    },
  },

  color_schemes = { ["OneHalfDark"] = scheme },
  color_scheme = "OneHalfDark",

  scrollback_lines = 5000,
  enable_scroll_bar = true,
  
  -- Scrollbar width
  window_padding = { right = "0.75cell" },

  window_close_confirmation = "NeverPrompt",
  exit_behavior = "Close",

  -- Disable all binds with SUPER; conflicts with dwm
  keys = {
    {key="c", mods="SUPER", action="DisableDefaultAssignment"},
    {key="v", mods="SUPER", action="DisableDefaultAssignment"},
    {key="m", mods="SUPER", action="DisableDefaultAssignment"},
    {key="n", mods="SUPER", action="DisableDefaultAssignment"},
    {key="-", mods="SUPER", action="DisableDefaultAssignment"},
    {key="+", mods="SUPER", action="DisableDefaultAssignment"},
    {key="0", mods="SUPER", action="DisableDefaultAssignment"},
    {key="t", mods="SUPER", action="DisableDefaultAssignment"},
    {key="T", mods="SUPER", action="DisableDefaultAssignment"},
    {key="w", mods="SUPER", action="DisableDefaultAssignment"},
    {key="1", mods="SUPER", action="DisableDefaultAssignment"},
    {key="2", mods="SUPER", action="DisableDefaultAssignment"},
    {key="3", mods="SUPER", action="DisableDefaultAssignment"},
    {key="4", mods="SUPER", action="DisableDefaultAssignment"},
    {key="5", mods="SUPER", action="DisableDefaultAssignment"},
    {key="6", mods="SUPER", action="DisableDefaultAssignment"},
    {key="7", mods="SUPER", action="DisableDefaultAssignment"},
    {key="8", mods="SUPER", action="DisableDefaultAssignment"},
    {key="9", mods="SUPER", action="DisableDefaultAssignment"},
    {key="r", mods="SUPER", action="DisableDefaultAssignment"},
    {key="k", mods="SUPER", action="DisableDefaultAssignment"},
    {key="f", mods="SUPER", action="DisableDefaultAssignment"},
  };
}
