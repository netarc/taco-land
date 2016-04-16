data:extend({
  {
    type = "container",
    name = "legendary-cache",
    icon = "__TacoLand__/modules/world-loot/graphics/icons/rare-cache.png",
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 2},
    max_health = 50,
    corpse = "small-remnants",
    collision_box = {{-0.35, -0.35}, {0.35, 0.35}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    inventory_size = 16,
    open_sound = { filename = "__base__/sound/wooden-chest-open.ogg" },
    close_sound = { filename = "__base__/sound/wooden-chest-close.ogg" },
    vehicle_impact_sound =  { filename = "__base__/sound/car-wood-impact.ogg", volume = 1.0 },
    picture =
    {
      filename = "__TacoLand__/modules/world-loot/graphics/entity/rare-cache.png",
      priority = "extra-high",
      width = 46,
      height = 33,
      shift = {0.3, 0}
    }
  }
})
