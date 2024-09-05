-- Pull in the wezterm API
local wezterm = require("wezterm")
local keymap_module = require("keymaps")
local launch_menu_module = require("launch_menu")

-- This will hold the configuration.
local config = wezterm.config_builder()
local act = wezterm.action

-- Theme configurations
config.color_scheme = "Vs Code Dark+ (Gogh)"
config.font = wezterm.font("SF Mono", { weight = "Regular", italic = false })
config.font_size = 10
config.default_cursor_style = "BlinkingBar"
config.initial_rows = 55
config.initial_cols = 240
-- config.window_background_opacity = 0.25
-- config.win32_system_backdrop = "Mica"
config.hide_tab_bar_if_only_one_tab = true
config.switch_to_last_active_tab_when_closing_tab = true
config.tab_bar_at_bottom = true

config.keys = {
  {
		key = "r",
		mods = "CTRL|ALT",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "w",
		mods = "CTRL",
		action = wezterm.action.CloseCurrentPane({ confirm = false }),
	},
	{
		key = "w",
		mods = "CTRL|SHIFT",
		action = wezterm.action.CloseCurrentTab({ confirm = false }),
	},
  {
		key = "l",
		mods = "ALT",
		action = wezterm.action.ShowLauncherArgs({
			flags = "FUZZY|TABS|LAUNCH_MENU_ITEMS",
		}),
	},
	{
		key = "P",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ActivateCommandPalette,
	},
}

-- Keymaps configurations
keymap_module.add_keymaps(config)

-- Set right click action to copy and paste
config.mouse_bindings = {
	{
		event = { Down = { streak = 1, button = "Right" } },
		mods = "NONE",
		action = wezterm.action_callback(function(window, pane)
			local has_selection = window:get_selection_text_for_pane(pane) ~= ""
			if has_selection then
				window:perform_action(act.CopyTo("ClipboardAndPrimarySelection"), pane)
				window:perform_action(act.ClearSelection, pane)
			else
				window:perform_action(act({ PasteFrom = "Clipboard" }), pane)
			end
		end),
	},
}

-- Set default launching program and launch menu items
config.launch_menu = {}
launch_menu_module.add_launch_menu_items(config)
launch_menu_module.set_default_prog(config)

return config
