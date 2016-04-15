local module = {}
local file_globals = '.globals'
local file_main = '.control'
local file_data = '.data'

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

  if not status and not string.find(err, file_globals .. ' not found') then
    assert(false, err)
  end

  require(name .. file_main)
end

function module.data(name)
  local status, err = pcall(function()
    require(name .. file_data)
  end)

  if not status and not string.find(err, file_data .. ' not found') then
    assert(false, err)
  end
end

return module
