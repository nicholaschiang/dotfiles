-- Pull in the wezterm API
local wezterm = require 'wezterm'
local mux = wezterm.mux

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- Spawn a Ubuntu WSL shell in login mode
config.default_prog = { 'ubuntu2204.exe' }

-- For example, changing the color scheme:
config.color_scheme = 'Solarized Dark (Gogh)'

-- Use Iosevka font
config.font = wezterm.font('Iosevka')
config.font_size = 12

-- Remove window padding
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

-- Hide the tab bar (unless there are 2+ tabs)
config.hide_tab_bar_if_only_one_tab = true

-- Automatically maximize new windows
-- (https://github.com/wezterm/wezterm/issues/284#issuecomment-1177628870)
-- (https://github.com/wezterm/wezterm/issues/284#issuecomment-1189748208)
-- (https://wezterm.org/config/lua/gui-events/gui-startup.html)
wezterm.on("gui-startup", function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

-- And finally, return the configuration to wezterm
return config
