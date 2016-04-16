local recipe = require("util.data-recipe")

recipe.remove("lab")
recipe.add({
  type = "recipe",
  name = "research-station",
  energy_required = 20,
  ingredients = {
    {"electronic-circuit", 10},
    {"iron-gear-wheel", 10},
    {"basic-transport-belt", 4}
  },
  result = "research-station",
  enabled = true
})
