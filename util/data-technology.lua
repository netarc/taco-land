local module = {}

function module.remove(name)
  data.raw.technology[name] = nil
end

function module.add(name, technology)
  module.remove(name)
  data.raw.technology[name] = technology
end

function module.replace_science_pack_from_all(old, new)
  for _, technology in pairs(data.raw.technology) do
    for i, ingredient in ipairs(technology.unit.ingredients) do
      if ingredient[1] == old or ingredient.name == old then
        table.remove(technology.unit.ingredients, i)
        table.insert(technology.unit.ingredients, {new, ingredient[2] or ingredient.amount})
      end
    end
  end
end

function module.remove_science_pack_from_all(pack)
  for _, technology in pairs(data.raw.technology) do
    for i, ingredient in ipairs(technology.unit.ingredients) do
      if ingredient[1] == pack or ingredient.name == pack then
        table.remove(technology.unit.ingredients, i)
      end
    end
  end
end

return module
