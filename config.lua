return {
  modules = {
    -- 'ores',
    'research-station',
    -- 'resource-expansion',
    'world-loot'
  },
  resource = {
    expansion = {
      -- The ratio per chunk away from start position
      density_distance_ratio = 0.02 -- every 50 chunks(1600 squares) double ore density
    }
  },
  research_station = {
    -- how many units until we will likely encounter a research station again
    frequency = 500,
    -- research modifier speed
    speed = 3
  }
}
