local module = {}
local path_graphics = "__TacoLand__/modules/ores/graphics"

local function create_ore_item(ore)
  data:extend({
    {
      type = "item",
      name = ore.name,
      icon = ore.item.icon,
      flags = {"goes-to-main-inventory"},
      subgroup = ore.item.subgroup and ore.item.subgroup or "raw-resource",
      order = "b-d[" .. ore.name .."]",
      stack_size = ore.item.stack_size and ore.item.stack_size or 200
    }
  })
end

local function create_ore_particle(ore)
  local tint = ore.sprite.tint or ore.resource.tint
  local pictures = {
    {
      filename = path_graphics .. "/entity/common/ore-particle-1.png",
      priority = "extra-high",
      width = 5,
      height = 5,
      frame_count = 1
    },
    {
      filename = path_graphics .. "/entity/common/ore-particle-2.png",
      priority = "extra-high",
      width = 7,
      height = 5,
      frame_count = 1
    },
    {
      filename = path_graphics .. "/entity/common/ore-particle-3.png",
      priority = "extra-high",
      width = 6,
      height = 7,
      frame_count = 1
    },
    {
      filename = path_graphics .. "/entity/common/ore-particle-4.png",
      priority = "extra-high",
      width = 9,
      height = 8,
      frame_count = 1
    },
    {
      filename = path_graphics .. "/entity/common/ore-particle-5.png",
      priority = "extra-high",
      width = 5,
      height = 5,
      frame_count = 1
    },
    {
      filename = path_graphics .. "/entity/common/ore-particle-6.png",
      priority = "extra-high",
      width = 6,
      height = 4,
      frame_count = 1
    },
    {
      filename = path_graphics .. "/entity/common/ore-particle-7.png",
      priority = "extra-high",
      width = 7,
      height = 8,
      frame_count = 1
    },
    {
      filename = path_graphics .. "/entity/common/ore-particle-8.png",
      priority = "extra-high",
      width = 6,
      height = 5,
      frame_count = 1
    }
  }

  ore.particle = ore.name .. "-particle"

  if tint then
    for _, picture in ipairs(data.raw.resource) do
      picture.tint = tint
    end
  end

  data:extend({
    {
      type = "particle",
      name = ore.particle,
      flags = {"not-on-map"},
      life_time = 180,
      pictures = pictures,
      shadows = {
        {
          filename = path_graphics .. "/entity/common/ore-particle-shadow-1.png",
          priority = "extra-high",
          width = 5,
          height = 5,
          frame_count = 1
        },
        {
          filename = path_graphics .. "/entity/common/ore-particle-shadow-2.png",
          priority = "extra-high",
          width = 7,
          height = 5,
          frame_count = 1
        },
        {
          filename = path_graphics .. "/entity/common/ore-particle-shadow-3.png",
          priority = "extra-high",
          width = 6,
          height = 7,
          frame_count = 1
        },
        {
          filename = path_graphics .. "/entity/common/ore-particle-shadow-4.png",
          priority = "extra-high",
          width = 9,
          height = 8,
          frame_count = 1
        },
        {
          filename = path_graphics .. "/entity/common/ore-particle-shadow-5.png",
          priority = "extra-high",
          width = 5,
          height = 5,
          frame_count = 1
        },
        {
          filename = path_graphics .. "/entity/common/ore-particle-shadow-6.png",
          priority = "extra-high",
          width = 6,
          height = 4,
          frame_count = 1
        },
        {
          filename = path_graphics .. "/entity/common/ore-particle-shadow-7.png",
          priority = "extra-high",
          width = 7,
          height = 8,
          frame_count = 1
        },
        {
          filename = path_graphics .. "/entity/common/ore-particle-shadow-8.png",
          priority = "extra-high",
          width = 6,
          height = 5,
          frame_count = 1
        }
      }
    }
  })
end

local function create_ore_stages(ore)
  local width = ore.sprite.width or 38
  local height = ore.sprite.height or 38
  local frame_count = ore.sprite.frame_count or 4
  local variation_count = #ore.sprite.stage_counts or 8

  local stages = {
    sheet = {
      filename = ore.sprite.filename,
      priority = "extra-high",
      width = width,
      height = height,
      frame_count = frame_count,
      variation_count = variation_count
    }
  }

  if ore.sprite.tint then
    stages.sheet.tint = ore.sprite.tint
  end

  return stages
end

local function create_ore_resource(ore)
  local stages = create_ore_stages(ore)
  local default_counts = {1000, 600, 400, 200, 100, 50, 20, 1}
  local resource = {
    type = "resource",
    name = ore.name,
    icon = ore.item.icon,
    flags = {"placeable-neutral"},
    order = "b-d-" .. ore.name,
    minable = {
      hardness = ore.hardness or 0.9,
      mining_time = ore.mining_time or 2,
      mining_particle = ore.particle,
      result = ore.name
    },
    collision_box = {{ -0.1, -0.1}, {0.1, 0.1}},
    selection_box = {{ -0.5, -0.5}, {0.5, 0.5}},
    autoplace = ore.autoplace,
    stage_counts = ore.sprite.stage_counts or default_counts,
    stages = stages
  }

  if ore.resource then
    if ore.resource.tint then
      resource.tint = ore.resource.tint
    end

    if ore.resource.map_color then
      resource.map_color = ore.resource.map_color
    end
  end

  data:extend({resource})
end

local function define_ore_data(ore)
  if not ore.particle then
    create_ore_particle(ore)
  else
    data:extend({ore.particle})
  end

  create_ore_item(ore)
  create_ore_resource(ore)
end

local function define_ore_control(ore)
  if data.raw.resource[ore.name] then
    data:extend({
      {
        type = "autoplace-control",
        name = ore.name,
        richness = true,
        order = "b-d-" .. ore.name
      },
      {
        type = "noise-layer",
        name = ore.name
      },
    })
  end
end

function module.define_ore(ore)
  define_ore_data(ore)
  define_ore_control(ore)
end

return module
