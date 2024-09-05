local module = {}

local default_prog = { "wsl.exe", "-d", "Ubuntu-22.04", "--cd", "~" }

local items = {
	{ label = "Ubuntu", args = { "wsl.exe", "-d", "Ubuntu-22.04", "--cd", "~" } },
	{
		label = "PowerShell",
		args = { "C:\\Program Files\\PowerShell\\7\\pwsh.exe" },
	},
}

function module.add_launch_menu_items(config)
  for key,value in ipairs(items) do
    table.insert(config.launch_menu, value)
  end
end

function module.set_default_prog(config)
  config.default_prog = default_prog
end

-- return our module table
return module