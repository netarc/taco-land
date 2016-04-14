local module = {}
local events = {}
local scripts_init = nil
local scripts_onload = nil

local function setup()
  if not events then events = {} end
  if not scripts then scripts = {} end
end

function module.on_event(event_name, hook)
  setup()

  if not events[event_name] then
    events[event_name] = {}
    script.on_event(event_name, function(event)
      for _,hook in ipairs(events[event_name]) do
        hook(event)
      end
    end)
  end

  table.insert(events[event_name], hook)
end

function module.on_init(hook)
  if not scripts_init then
    scripts_init = {}
    script.on_init(function()
      for _,hook in ipairs(scripts_init) do
        hook()
      end
    end)
  end

  table.insert(scripts_init, hook)
end

function module.on_load(hook)
  if not scripts_onload then
    scripts_onload = {}
    script.on_load(function()
      for _,hook in ipairs(scripts_onload) do
        hook()
      end
    end)
  end

  table.insert(scripts_onload, hook)
end

return module
