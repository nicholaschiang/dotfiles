-- Pull in the wezterm API
local wezterm = require 'wezterm'
local mux = wezterm.mux

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- Spawn a fish shell in login mode
config.default_prog = { 'fish', '-l' }

-- For example, changing the color scheme:
config.color_scheme = 'Solarized Dark (Gogh)'

-- Use Iosevka font
config.font = wezterm.font('Iosevka')
config.font_size = 12
config.adjust_window_size_when_changing_font_size = false

-- Sets the font for the window frame (tab bar)
config.window_frame = {
    font = wezterm.font {
        family = "Iosevka Term",
        weight = "Bold"
    },
}

-- Remove window padding
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

-- Check for updates
config.check_for_updates = true

-- Hide the tab bar (unless there are 2+ tabs)
config.hide_tab_bar_if_only_one_tab = true

-- Fixes an issue with key repeats when navigating Vim
-- (https://www.reddit.com/r/commandline/comments/1621suy/help_issue_with_wezterm_and_vim_key_repeat/)
config.use_ime = false

-- make username/project paths clickable. this implies paths like the following are for github.
-- ( "nvim-treesitter/nvim-treesitter" | wbthomason/packer.nvim | wez/wezterm | "wez/wezterm.git" )
-- as long as a full url hyperlink regex exists above this it should not match a full url to
-- github or gitlab / bitbucket (i.e. https://gitlab.com/user/project.git is still a whole clickable url)
config.hyperlink_rules = wezterm.default_hyperlink_rules()
table.insert(config.hyperlink_rules, {
  regex = [[["]?([\w\d]{1}[-\w\d]+)(/){1}([-\w\d\.]+)["]?]],
  format = 'https://www.github.com/$1/$3',
})

-- Automatically toggle fullscreen on new windows
-- (https://wezterm.org/config/lua/gui-events/gui-startup.html)
-- (https://github.com/wezterm/wezterm/discussions/2506#discussioncomment-3619555)
--wezterm.on("gui-startup", function(cmd)
  --local tab, pane, window = mux.spawn_window(cmd or {})
  --window:gui_window():perform_action(wezterm.action.ToggleFullScreen, pane)
--end)

-- And finally, return the configuration to wezterm
return config
