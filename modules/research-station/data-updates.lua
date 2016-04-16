local recipe = require('util.data-recipe')
local technology = require('util.data-technology')

-- recipe.remove('science-pack-1')
-- recipe.remove('science-pack-2')
-- recipe.remove('science-pack-3')
-- recipe.remove('alien-science-pack')

technology.replace_science_pack_from_all('science-pack-1', 'quantum-crystal')
technology.remove_science_pack_from_all('science-pack-2')
technology.remove_science_pack_from_all('science-pack-3')
technology.remove_science_pack_from_all('alien-science-pack')
