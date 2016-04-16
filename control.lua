require "defines"
local module = require("util.module")

-- Ensure random is properly seeded and discard our some samples that might be too similar
-- require "os"
-- math.randomseed( tonumber(tostring(os.time()):reverse():sub(1,6)) )
-- math.random(); math.random(); math.random()

module.load("modules.ores")
module.load("modules.research-station")
module.load("modules.resource-expansion")
module.load("modules.world-loot")
