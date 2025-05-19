-- Pull in the wezterm API
local wezterm = require 'wezterm'
local mux = wezterm.mux

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- Spawn a Ubuntu WSL shell in login mode
config.default_prog = { '/opt/homebrew/bin/bash' }

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

-- Fixes an issue with key repeats when navigating Vim
-- (https://www.reddit.com/r/commandline/comments/1621suy/help_issue_with_wezterm_and_vim_key_repeat/)
config.use_ime = false

-- Automatically toggle fullscreen on new windows
-- (https://wezterm.org/config/lua/gui-events/gui-startup.html)
-- (https://github.com/wezterm/wezterm/discussions/2506#discussioncomment-3619555)
wezterm.on("gui-startup", function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():perform_action(wezterm.action.ToggleFullScreen, pane)
end)

-- And finally, return the configuration to wezterm
return config
