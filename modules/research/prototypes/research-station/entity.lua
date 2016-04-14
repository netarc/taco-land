data:extend({
  {
    type = "mining-drill",
    name = "research-station",
    icon = "__base__/graphics/icons/lab.png",
    flags = {"placeable-neutral", "player-creation"},
    minable = {
      mining_time = 1,
      result = "research-station"
    },
    max_health = 300,
    resource_categories = {"quantum-research"},
    corpse = "big-remnants",
    collision_box = {{ -1.4, -1.4}, {1.4, 1.4}},
    selection_box = {{ -1.5, -1.5}, {1.5, 1.5}},
    vehicle_impact_sound = {
      filename = "__base__/sound/car-metal-impact.ogg",
      volume = 0.65
    },
    working_sound = {
      sound = {
        filename = "__base__/sound/lab.ogg",
        volume = 0.7
      },
      apparent_volume = 1
    },
    animations = {
      north = {
        filename = "__base__/graphics/entity/lab/lab.png",
        width = 113,
        height = 91,
        frame_count = 33,
        line_length = 11,
        animation_speed = 1 / 3,
        shift = {0.2, 0.15}
      },
      east = {
        filename = "__base__/graphics/entity/lab/lab.png",
        width = 113,
        height = 91,
        frame_count = 33,
        line_length = 11,
        animation_speed = 1 / 3,
        shift = {0.2, 0.15}
      },
      south = {
        filename = "__base__/graphics/entity/lab/lab.png",
        width = 113,
        height = 91,
        frame_count = 33,
        line_length = 11,
        animation_speed = 1 / 3,
        shift = {0.2, 0.15}
      },
      west = {
        filename = "__base__/graphics/entity/lab/lab.png",
        width = 113,
        height = 91,
        frame_count = 33,
        line_length = 11,
        animation_speed = 1 / 3,
        shift = {0.2, 0.15}
      }
    },
    mining_speed = 0,
    energy_source = {
      type = "electric",
      -- will produce this much * energy pollution units per tick
      emissions = 0.15 / 1.5,
      usage_priority = "secondary-input"
    },
    energy_usage = "90kW",
    mining_power = 3,
    resource_searching_radius = 0.49,
    vector_to_place_result = {0, 0},
    radius_visualisation_picture = {
      filename = "__base__/graphics/entity/basic-mining-drill/mining-drill-radius-visualization.png",
      width = 12,
      height = 12
    }
  }
})
