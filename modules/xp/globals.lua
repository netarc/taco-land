-- TODO: Numbers should come from config?

-- bonus_earn is either a flat number multiplier or a table {flat, variance}
local function create_xp_object(xp_range, bonus_earn)
  return {
    total = 0,
    current = 0,
    needed = math.random(xp_range[1], xp_range[2]),
    level = 1,
    bonus = 0,
    bonus_earn = bonus_earn
  }
end

return {
  tacoland = {
    xp = {
      crafting = create_xp_object({25, 150}, {0.3, 0.2}),
      mining = create_xp_object({25, 150}, {0.3, 0.2}),
      combat = create_xp_object({100, 250}, {0.05, 0.01})
    }
  }
}
