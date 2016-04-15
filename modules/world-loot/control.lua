require "defines"
local events = require("util.events")

local function setup_initial_loot()
	if #global.tacoland.WorldLoot.Caches.basic.loot ~= 0 then
		return
	end

	for name, prototype in pairs(game.item_prototypes) do
		if prototype.group.name == "intermediate-products" then
			table.insert(global.tacoland.WorldLoot.Caches.basic.loot, name)
		end

		if prototype.group.name == "combat" then
			table.insert(global.tacoland.WorldLoot.Caches.rare.loot, name)
		end
	end
end

function get_random_cache()
	local CacheTypes = {}

	for name,_ in pairs(global.tacoland.WorldLoot.Caches) do
		table.insert(CacheTypes, name)
	end

	if #CacheTypes == 0 then
		return nil
	end

	return global.tacoland.WorldLoot.Caches[CacheTypes[math.random(#CacheTypes)]]
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
  setup_initial_loot()
end)

events.on_load(function()
  setup_initial_loot()
end)

-- Chunks are 32x32
events.on_event(defines.events.on_chunk_generated, function(event)
	spawn_cache(event, 32)
end)
