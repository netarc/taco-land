local module = {}

function module.remove(name)
  data.raw.recipe[name] = nil
end

function module.add(name, recipe)
  module.remove(name)
  data.raw.recipe[name] = recipe
end

-- function module.remove_item(name, item)
--   for i, ingredient in pairs(data.raw.recipe[name].ingredients) do
--     if ingredient[1] == item or ingredient.name == item then
--       table.remove(data.raw.recipe[name].ingredients, i)
--     end
--   end
-- end
--
-- function module.remove_item_from_all(item)
--   for _, recipe in ipairs(data.raw.recipe) do
--     for i, ingredient in pairs(recipe.ingredients) do
--       if ingredient[1] == item or ingredient.name == item then
--         table.remove(recipe.ingredients, i)
--       end
--     end
--   end
-- end
--
-- function module.remove_items_from_all(items)
--   for _, recipe in ipairs(data.raw.recipe) do
--     for i, ingredient in pairs(recipe.ingredients) do
--       for _, item in pairs(items) do
--         if ingredient[1] == item or ingredient.name == item then
--           table.remove(recipe.ingredients, i)
--         end
--       end
--     end
--   end
-- end

return module
