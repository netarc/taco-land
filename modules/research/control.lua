require "defines"
local events = require("util.events")
local config = require("config")

local ResearchNode = "quantum-vein"

function SpawnCrystalVein(AREA, MAX_AMOUNT, CHUNKS, STATEMENT, event)
	local PosX = event.area.left_top.x+math.random(AREA)
	local PosY = event.area.left_top.y+math.random(AREA)
	local surface = game.get_surface("nauvis")

	if surface.can_place_entity{name=(ResearchNode), position={PosX,PosY}} then
		surface.create_entity({
      name = ResearchNode,
      position = {PosX, PosY},
      force = game.forces.neutral
    })
	end
end

-- Chunks are 32x32
events.on_event(defines.events.on_chunk_generated, function(event)
	-- TODO: we only want to spawn a quantum vein spaced out great distance from each other
	SpawnCrystalVein(63, 10, 1000, false, event)
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
