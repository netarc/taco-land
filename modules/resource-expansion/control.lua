require "defines"
local config = require("config")
local events = require("util.events")

-- TODO: we really need to make this smarter by tracking existing fields and comparing
-- distance to similiar field types instead of just distance from start pos (0,0)
events.on_event(defines.events.on_chunk_generated, function(event)
	local distX = math.abs(event.area.left_top.x)
	local distY = math.abs(event.area.left_top.y)
	local distance = math.floor(math.sqrt((distX * distX) + (distY * distY)) / 32)
	local mult = 1 + (config.resource.expansion.density_distance_ratio * distance)

  local resources = event.surface.find_entities_filtered({
		area = {
			{event.area.left_top.x, event.area.left_top.y},
			{event.area.right_bottom.x, event.area.right_bottom.y}
		},
		type="resource"
	})

	for _,resource in pairs(resources) do
		resource.amount = math.floor(resource.amount * mult)
	end
end)
