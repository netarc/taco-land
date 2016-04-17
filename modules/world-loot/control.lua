require "defines"
local events = require("util.events")
local logger = require("util.logger")





local function get_random_cache()
	local caches = {}

	for name,_ in pairs(global.tacoland.world_loot.caches) do
		table.insert(caches, name)
	end

	if #caches == 0 then
		return nil
	end

	return global.tacoland.world_loot.caches[caches[math.random(#caches)]]
end

function spawn_cache(event, area)
	-- these should be configured per "event" of cache spawn
	local cfg_max_stack_size = 10
	local cfg_min_items = 2
	local cfg_max_items = 5
	--
	local cache = get_random_cache()

	if not cache or #cache.loot == 0 then
		return
	end

	local pos = {
		event.area.left_top.x + math.random(area),
		event.area.left_top.y + math.random(area)
	}

	if game.get_surface("nauvis").can_place_entity({name=cache.container, position=pos}) then
		local container = game.get_surface("nauvis").create_entity({name=cache.container, position=pos, force=game.forces.neutral})

		for i = 1, (math.random(cfg_min_items, cfg_max_items)) do
			local item = cache.loot[math.random(#cache.loot)]
			local amount = math.random(cfg_max_stack_size)

			container.insert{name=item, count=amount}
		end
	end
end


events.on_init(function()

end)

events.on_load(function()

end)

-- Chunks are 32x32
events.on(defines.events.on_chunk_generated, function(event)
	spawn_cache(event, 32)
end)
