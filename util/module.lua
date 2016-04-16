local module = {}
local config = require('config')
local path_modules = 'modules.'
local file_globals = '.globals'
local file_main = '.control'
local file_data = '.data'
local file_data_updates = '.data-updates'

local function table_default(target, other)
  local changed = false

  if type(target) == 'table' and type(other) == 'table' then
    for k, v in pairs(other) do
      if type(target[k]) == 'nil' then
        target[k] = v
        changed = true
      elseif type(v) == 'table' and type(target[k]) == 'table' then
        if table_default(target[k], v) then
          changed = true
        end
      end
    end
  end

  return changed
end

function module.load(name)
  local status, err = pcall(function()
    local module_defaults = require(name .. '.globals')
    if type(module_defaults) == 'table' then
      table_default(global, module_defaults)
    end
  end)

  if not status and not string.find(err, file_globals .. ' not found', 1, true) then
    assert(false, err)
  end

  require(name .. file_main)
end

function module.data(name)
  local status, err = pcall(function()
    require(name .. file_data)
  end)

  if not status and not string.find(err, file_data .. ' not found', 1, true) then
    assert(false, err)
  end
end

function module.data_updates(name)
  local status = true
  local status, err = pcall(function()
    require(name .. file_data_updates)
  end)

  if not status and not string.find(err, file_data_updates .. ' not found', 1, true) then
    assert(false, err)
  end
end

function module.init_load()
  for _,mod in pairs(config.modules) do
    module.load(path_modules .. mod)
  end
end

function module.init_data()
  for _,mod in pairs(config.modules) do
    module.data(path_modules .. mod)
  end
end

function module.init_data_updates()
  for _,mod in pairs(config.modules) do
    module.data_updates(path_modules .. mod)
  end
end

return module
