local module = {}

function module.print(message)
	for _, player in pairs(game.players) do
		player.print(message)
	end
end

return module
