local module = {}
local file_globals = '.globals'
local file_main = '.control'
local file_data = '.data'

local function tdefault(a, b)
  local result = false

  if type(a) == 'table' and type(b) == 'table' then
    for k, v in pairs(b) do
      if type(a[k]) == 'nil' then
        a[k] = v
        result = true
      elseif type(v) == 'table' and type(a[k]) == 'table' then
        if merge(a[k], v) then
          result = true
        end
      end
    end
  end

  return result
end

function module.load(name)
  local status, err = pcall(function()
    local module_defaults = require(name .. '.globals')
    if type(module_defaults) == 'table' then
      tdefault(global, module_defaults)
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
