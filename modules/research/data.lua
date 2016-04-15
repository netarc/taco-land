require("modules.research.prototypes.quantum-crystal.item")
require("modules.research.prototypes.quantum-vein.resource")
require("modules.research.prototypes.research-station.item")
require("modules.research.prototypes.research-station.entity")
require("modules.research.prototypes.research-station.recipe")


data:extend({
  {
    type = "technology",
    name = "logistics",
    icon = "__base__/graphics/technology/logistics.png",
    effects = {
      {
        type = "unlock-recipe",
        recipe = "basic-transport-belt"
      },
      {
        type = "unlock-recipe",
        recipe = "basic-transport-belt-to-ground"
      },
      {
        type = "unlock-recipe",
        recipe = "basic-splitter"
      },
    },
    unit = {
      count = 1,
      ingredients = {
        {"quantum-crystal", 1}
      },
      time = 10
    },
    order = "l-4",
  },
  {
    type = "technology",
    name = "logistics-4",
    icon = "__base__/graphics/technology/logistics.png",
    effects = {
      {
        type = "unlock-recipe",
        recipe = "basic-transport-belt"
      },
      {
        type = "unlock-recipe",
        recipe = "basic-transport-belt-to-ground"
      },
      {
        type = "unlock-recipe",
        recipe = "basic-splitter"
      },
    },
    prerequisites = {"logistics"},
    unit = {
      count = 2,
      ingredients = {
        {"quantum-crystal", 1}
      },
      time = 10
    },
    order = "l-4",
  },
  {
    type = "technology",
    name = "logistics-5",
    icon = "__base__/graphics/technology/logistics.png",
    effects = {
      {
        type = "unlock-recipe",
        recipe = "basic-transport-belt"
      },
      {
        type = "unlock-recipe",
        recipe = "basic-transport-belt-to-ground"
      },
      {
        type = "unlock-recipe",
        recipe = "basic-splitter"
      },
    },
    prerequisites = {"logistics-4"},
    unit = {
      count = 5,
      ingredients = {
        {"quantum-crystal", 1}
      },
      time = 10
    },
    order = "l-5",
  },
})
