require "defines"
local events = require("scripts.events")

-- Ensure random is properly seeded and discard our some samples that might be too similar
-- require "os"
-- math.randomseed( tonumber(tostring(os.time()):reverse():sub(1,6)) )
-- math.random(); math.random(); math.random()

local function setup_globals()
  if not global.tacoland then global.tacoland = {} end
end

events.on_init(function()
  setup_globals()
end)

require("modules.ores.control")
require("modules.research.control")
require("modules.resource-expansion.control")
require("modules.world-loot.control")
