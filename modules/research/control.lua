require "util"
require "defines"

local events = require("util.events")
local config = require("config")

local cfg_entity_name = "quantum-vein"


function spawn_quantum_vein(event, area)
	local PosX = event.area.left_top.x + math.random(area)
	local PosY = event.area.left_top.y + math.random(area)
	local surface = game.get_surface("nauvis")

	if surface.can_place_entity{name=cfg_entity_name, position={PosX,PosY}} then
		local entity = surface.create_entity({
      name = cfg_entity_name,
      position = {PosX, PosY},
      force = game.forces.neutral
    })

		table.insert(global.tacoland.research.veins, entity)
	end
end

-- Chunks are 32x32
events.on_event(defines.events.on_chunk_generated, function(event)
	if math.random(100) <= 10 then
		-- abort if we are within X distance of another vein
		for _,vein in pairs(global.tacoland.research.veins) do
			if util.distance(event.area.left_top, vein.position) < 3500 then
				return
			end
		end

		spawn_quantum_vein(event, 32)
	end
end)

events.on_event(defines.events.on_tick, function(event)
	if not game.player.force.current_research then
		return
	end

	local technology = game.player.force.current_research
	local delta = (1 / technology.research_unit_energy) / technology.research_unit_count
	local station_count = game.player.force.get_entity_count("research-station")
	-- TODO: We really should check to see if our stations are 100% powered
	local progress = game.player.force.research_progress + (station_count * delta * config.research.speed)

	if progress > 1 then progress = 1 end
	game.player.force.research_progress = progress
end)
