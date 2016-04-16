data:extend({
  {
    type = "resource",
    name = "quantum-vein",
    icon = "__TacoLand__/modules/research-station/graphics/icons/quantum-vein.png",
    flags = {"placeable-neutral"},
    category = "quantum-research",
    order="a-b-b",
    infinite = true,
    minable = {
      hardness = 1,
      mining_time = 1,
      result = "quantum-crystal"
    },
    collision_box = {{ -0.1, -0.1}, {0.1, 0.1}},
    selection_box = {{ -0.5, -0.5}, {0.5, 0.5}},
    stage_counts = {0},
    stages =
    {
      sheet =
      {
        filename = "__TacoLand__/modules/research-station/graphics/entity/quantum-vein.png",
        priority = "extra-high",
        width = 75,
        height = 61,
        frame_count = 1,
        variation_count = 1,
        shift = {0.25, -0.03125}
      }
    },
    map_color = {r=0.2, g=1.0, b=0.2},
    map_grid = false
  }
})
