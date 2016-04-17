require "defines"
local events = require("util.events")
local logger = require("util.logger")


local function get_random_cache()
	local roll = math.random(100)
	
	-- 5% legendary (1,2,3 on the roll)
	if (roll <= 5) then
		return global.tacoland.world_loot.caches["legendary"]
	-- 10% epic (5-15 on the roll)
	elseif (roll <= 15 and roll > 5) then
		return global.tacoland.world_loot.caches["epic"]
	-- 25% rare (15-40 on the roll)
	elseif (roll <= 40 and roll > 15) then
		return global.tacoland.world_loot.caches["rare"]
	-- 60% basic (40-100 on the roll )
	elseif ( roll > 40) then
		return global.tacoland.world_loot.caches["basic"]
	end
end

function spawn_cache(event, area)

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

		insert_loot(container, cache.loot, 5, 5)
		insert_loot(container, global.tacoland.world_loot.raw_resources, 3, 100)
		insert_loot(container, global.tacoland.world_loot.basic_materials, 3, 20)
		if (cache.container ~= "basic-cache") then
			insert_loot(container, global.tacoland.world_loot.advanced_materials, 3, 20)
		end
    
	end
end

function insert_loot(container, loot_table, num_items, max_stack_size)
	for i = 1, (math.random(num_items)) do
		local item = loot_table[math.random(#loot_table)]
		local amount = math.random(max_stack_size)

		container.insert{name=item, count=amount}
	end
end

events.on_init(function()

end)

events.on_load(function()

end)

-- Chunks are 32x32
events.on(defines.events.on_chunk_generated, function(event)
	local roll = math.random(100)
	-- 15% to spawn a cache
	if (roll <= 15 ) then
		spawn_cache(event, 32)
	end
end)
