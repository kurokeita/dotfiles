-- Pull in the wezterm API
local wezterm = require("wezterm")

local module = {}

local keymaps = {}

function module.add_keymaps(config)
  for key,value in ipairs(keymaps) do
    table.insert(config.keys, value)
  end
end

-- return our module table
return module