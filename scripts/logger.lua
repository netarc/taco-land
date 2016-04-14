local module = {}

function module.debug(message)
  game.write_file("debug.txt", message .. "\n", true)
end

return module
