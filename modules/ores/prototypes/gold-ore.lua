local util = require("modules.ores.util")

util.define_ore({
  name = "gold-ore",
  item = {
    icon = "__TacoLand__/modules/ores/graphics/icons/gold-ore.png"
  },
  resource = {
    tint = {
      r = 1, g = 0.75, b = 0
    },
    map_color = {
      r = 0.9, g = 0.63, b = 0
    }
  },
  sprite = {
    filename = "__TacoLand__/modules/ores/graphics/entity/gold-ore.png",
    stage_counts = {1000, 600, 400, 200, 100, 50, 20, 1}
  },
  hardness = 0.6,
  autoplace = {
    control = "gold-ore",
    sharpness = 1,
    richness_multiplier = 13000,
    richness_base = 350,
    size_control_multiplier = 0.06,
    peaks = {
      {
        influence = 0.15,
        starting_area_weight_optimal = 0,
        starting_area_weight_range = 0,
        starting_area_weight_max_range = 2,
      },
      {
        influence = 0.65,
        noise_layer = "gold-ore",
        noise_octaves_difference = -2.4,
        noise_persistence = 0.35,
        starting_area_weight_optimal = 0,
        starting_area_weight_range = 0,
        starting_area_weight_max_range = 2,
      },
    },
  }
})
