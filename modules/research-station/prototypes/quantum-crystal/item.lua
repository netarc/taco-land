data:extend({
  {
    type = "resource-category",
    name = "quantum-research"
  },
  {
    type = "tool",
    name = "quantum-crystal",
    icon = "__TacoLand__/modules/research-station/graphics/icons/quantum-crystal.png",
    flags = {"goes-to-main-inventory"},
    subgroup = "science-pack",
    order = "a[quantum-crystal]",
    stack_size = 200,
    durability = 1,
    durability_description_key = "description.science-pack-remaining-amount"
  }
})
