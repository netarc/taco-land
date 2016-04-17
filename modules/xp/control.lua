require "defines"

local events = require("util.events")
local players = require("util.players")

local function earn_xp(xp, amount)
	local bonus_earned = 0

	xp.total = xp.total + amount
	xp.current = xp.current + amount
	if xp.current < xp.needed then
		return false
	end

	xp.current = xp.current - xp.needed
	xp.needed = xp.needed * 2 + math.random(math.ceil(1 + xp.needed * 0.25))
	xp.level = xp.level + 1

	if type(xp.bonus_earn) == 'number' then
		bonus_earned = xp.bonus_earn
	else
		bonus_earned = xp.bonus_earn[1] + (math.random() * xp.bonus_earn[2])
	end
	-- keep fraction reasonable
	bonus_earned = math.modf(bonus_earned * 1000) / 1000
	xp.bonus = xp.bonus + bonus_earned

	return true, bonus_earned
end

local function earn_crafting_xp(event)
	local amount = event.item_stack.count / #game.players
	local leveled, bonus_earend = earn_xp(global.tacoland.xp.crafting, amount)

	if leveled then
		local player = game.forces.player
		player.manual_crafting_speed_modifier = player.manual_crafting_speed_modifier + bonus_earend
		players.print({"xp", {"crafting"}, bonus_earend})
	end
end

function earn_mining_xp(event)
	local amount = event.item_stack.count / #game.players
	local leveled, bonus_earend = earn_xp(global.tacoland.xp.mining, amount)

	if leveled then
		local player = game.forces.player
		player.manual_mining_speed_modifier = player.manual_mining_speed_modifier + bonus_earend
		players.print({"xp", {"mining"}, bonus_earend})
	end
end

function earn_combat_xp(event)
	local amount = 0

	if event.entity.type == "unit" then
		amount = 1 / #game.players
	elseif event.entity.type == "unit-spawner" then
		amount = 10 / #game.players
	end

	local leveled, bonus_earend = earn_xp(global.tacoland.xp.combat, amount)
	if leveled then
		local player = game.forces.player
		local categories = {
			"bullet",
			"rocket",
			"flame-thrower",
			"shotgun-shell",
			"railgun",
			"cannon-shell",
			"combat-robot-laser",
			"laser-turret",
			"electric",
			"capsule",
			"combat-robot-beam"
		}

		for _, name in ipairs(categories) do
			player.set_ammo_damage_modifier(name, player.get_ammo_damage_modifier(name) + bonus_earend)
			player.set_gun_speed_modifier(name, player.get_gun_speed_modifier(name) + bonus_earend)
		end

		players.print({"xp", {"combat"}, bonus_earend})
	end
end

events.on(defines.events.on_player_crafted_item, function(event)
	earn_crafting_xp(event)
end)

events.on(defines.events.on_player_mined_item, function(event)
	earn_mining_xp(event)
end)

events.on(defines.events.on_entity_died, function(event)
	earn_combat_xp(event)
end)
