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


	buildLootTable()
end


function buildLootTable()
	for Name,Tech in pairs(game.forces.player.technologies) do
		if game.forces.player.technologies[Name].effects then
			for i,Recipe in pairs(game.forces.player.technologies[Name].effects) do
				if Recipe.recipe then
					table.insert(global.tacoland.lootTable[getResearchLevel(Name)], Recipe.recipe)
				end
			end
		end
	end
end

function getResearchLevel(technology)
    local levels = {["science-pack-1"] = 1, ["science-pack-2"] = 2, ["science-pack-3"] = 3, ["alien-science-pack"] = 4}
    local level = 0
	local Tech = game.forces.player.technologies[technology]
    for _,t in pairs(Tech.research_unit_ingredients) do
        if levels[t.name] and levels[t.name] > level then
            level = levels[t.name]
		end
    end
    return level
end

local function get_random_cache()
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
			local item = global.tacoland.lootTable[1][math.random(#global.tacoland.lootTable[1])]
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