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
	-- these should be configured per "event" of cache spawn
	local cfg_max_stack_size = 5
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

		-- insert items
		for i = 1, (math.random(cfg_min_items, cfg_max_items)) do
			local item = cache.loot[math.random(#cache.loot)]
			local amount = math.random(cfg_max_stack_size)

			container.insert{name=item, count=amount}
		end
		
		-- insert raw raw_resources (1-3 resources up to 100 each)
		for i = 1, (math.random(3)) do
			local item = global.tacoland.world_loot.raw_resources[math.random(#global.tacoland.world_loot.raw_resources)]
			local amount = math.random(100)

			container.insert{name=item, count=amount}
		end
		
		-- insert basic materials (1-3 materials up to 20 each)
		for i = 1, (math.random(3)) do
			local item = global.tacoland.world_loot.basic_materials[math.random(#global.tacoland.world_loot.basic_materials)]
			local amount = math.random(20)

			container.insert{name=item, count=amount}
		end
		
		-- insert advanced materials into high level caches (1-3 materials up to 20 each)
		if (cache.container ~= "basic-cache") then
			for i = 1, (math.random(3)) do
				local item = global.tacoland.world_loot.advanced_materials[math.random(#global.tacoland.world_loot.advanced_materials)]
				local amount = math.random(20)

				container.insert{name=item, count=amount}
			end
		end

		
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
