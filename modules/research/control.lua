require "defines"
local events = require("util.events")

local ResearchNode = "quantum-vein"

function SpawnCrystalVein(AREA, MAX_AMOUNT, CHUNKS, STATEMENT, event)
	local PosX = event.area.left_top.x+math.random(AREA)
	local PosY = event.area.left_top.y+math.random(AREA)
	if game.get_surface("nauvis").can_place_entity{name=(ResearchNode), position={PosX,PosY}} then
		-- local Chest = game.get_surface("nauvis").create_entity{name=(BuildEntity), position={PosX,PosY}, force=game.forces.neutral}
		game.get_surface("nauvis").create_entity({
      name = ResearchNode,
      position = {PosX, PosY},
      force = game.forces.neutral
    })

		-- if fs.checkMatch100(60) and global.Counter.Chunks > CHUNKS and STATEMENT then
		-- 	for i = 1, (math.random(2,5)) do
		-- 		local Insert=global.RandomEntity.Special_Loot[math.random(#global.RandomEntity.Special_Loot)]
		-- 		local Amount = math.random(MAX_AMOUNT)
		-- 		Chest.insert{name=Insert, count=Amount}
		-- 		fs.SpawnCounter(3, Amount)
		-- 	debug("Generator: Chests with Special_Loot: Created "..BuildEntity.." at "..PosX..", "..PosY)
		-- 	end
		-- elseif fs.checkMatch100(60) and global.Counter.Chunks > CHUNKS and not STATEMENT then
		-- 	for i = 1, (math.random(2,5)) do
		-- 		local Insert=global.RandomEntity.Loot[math.random(#global.RandomEntity.Loot)]
		-- 		local Amount = math.random(MAX_AMOUNT)
		-- 		Chest.insert{name=Insert, count=Amount}
		-- 		fs.SpawnCounter(3, Amount)
		-- 	debug("Generator: Chests with Loot: Created "..BuildEntity.." at "..PosX..", "..PosY)
		-- 	end
		-- else
		-- 	fs.SpawnCounter(3, 0)
		-- debug("Generator: Chests: Created "..BuildEntity.." at "..PosX..", "..PosY)
		-- end
	end
end

-- Chunks are 32x32
events.on_event(defines.events.on_chunk_generated, function(event)
	SpawnCrystalVein(63, 10, 1000, false, event)
end)
