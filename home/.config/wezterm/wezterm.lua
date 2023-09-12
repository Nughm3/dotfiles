local wezterm = require("wezterm")
local mux = wezterm.mux

wezterm.on("gui-startup", function()
  local tab, pane, window = mux.spawn_window{}
  window:gui_window():maximize()
end)

return {
  color_scheme = "OneDark (base16)",
  default_prog = { "/run/current-system/sw/bin/fish" },

  font = wezterm.font("JetBrainsMono Nerd Font Mono"),
  font_size = 10.5,

  use_fancy_tab_bar = false,
  hide_tab_bar_if_only_one_tab = true,
  
  window_frame = {
    active_titlebar_bg = "#1e222a",
    inactive_titlebar_bg = "#1e222a",

    inactive_titlebar_border_bottom = "#1e222a",
    active_titlebar_border_bottom = "#1e222a",
    
    button_bg = "#1e222a",
    button_hover_bg = "#353b45",
  },

  colors = {
    tab_bar = {
      background = "#282c34",
      
      active_tab = {
        fg_color = "#c8ccd4",
        bg_color = "#353b45",

        intensity = "Bold",
      },
      
      inactive_tab = {
        fg_color = "#abb2bf",
        bg_color = "#282c34",
      },

      inactive_tab_hover = {
        fg_color = "#c8ccd4",
        bg_color = "#3e4451",
      },
      
      new_tab = {
        fg_color = "#c8ccd4",
        bg_color = "#282c34",
      },

      new_tab_hover = {
        fg_color = "#1e222a",
        bg_color = "#61afef",
      }
    },
  },

  window_close_confirmation = "NeverPrompt"
}
