require "util"
require "defines"

local events = require("util.events")
local config = require("config")

local cfg_entity_name = "quantum-vein"


function spawn_quantum_vein(pos, area)
	local position = {
		pos.x + math.random(area) - math.random(area * 2),
		pos.y + math.random(area) - math.random(area * 2)
	}
	local surface = game.get_surface("nauvis")

	if surface.can_place_entity{name=cfg_entity_name, position=position} then
		local entity = surface.create_entity({
      name = cfg_entity_name,
      position = position,
      force = game.forces.neutral
    })

		table.insert(global.tacoland.research.veins, entity)
		return entity
	end

	return nil
end

-- Chunks are 32x32
events.on(defines.events.on_chunk_generated, function(event)
	if #global.tacoland.research.veins == 0 then
		while not spawn_quantum_vein({x=0,y=0}, 128) do
		end
	elseif math.random(100) <= 10 then
		-- abort if we are within X distance of another vein
		for _,vein in pairs(global.tacoland.research.veins) do
			if util.distance(event.area.left_top, vein.position) < config.research_station.frequency then
				return
			end
		end

		spawn_quantum_vein(event.area.left_top, 32)
	end
end)

events.on(defines.events.on_tick, function(event)
	local technology = game.forces.player.current_research
	local progress = game.forces.player.research_progress
	local station_count = game.forces.player.get_entity_count("research-station")
	local crystal_count = 1

	if not technology then
		return
	end

	for _,ingredient in ipairs(technology.research_unit_ingredients) do
		if ingredient.name == 'quantum-crystal' then
			crystal_count = ingredient.amount
		end
	end

	local delta = 1 / (technology.research_unit_energy * crystal_count * technology.research_unit_count)
	-- TODO: We really should check to see if our stations are 100% powered
	progress = progress + (delta * config.research_station.speed) * station_count

	if progress > 1 then progress = 1 end
	game.forces.player.research_progress = progress
end)
