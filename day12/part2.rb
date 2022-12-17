# frozen_string_literal: true

UP = [0, -1].freeze
DOWN = [0, 1].freeze
LEFT = [-1, 0].freeze
RIGHT = [1, 0].freeze

ELEVATION_VALUES = ('a'..'z').zip(0..25).to_h
ELEVATION_VALUES['S'] = 0
ELEVATION_VALUES['E'] = 25

def main
  chart = File.open('./input.txt').readlines.map(&:strip).map(&:chars)
  starting_positions = find_pos(chart, 'a')
  end_pos = find_pos(chart, 'E').first

  step_memo = Array.new(chart.length) { Array.new(chart[0].length) }
  step_memo[end_pos[1]][end_pos[0]] = 0
  step_memo = explore_neighbors(chart, end_pos[0], end_pos[1], step_memo)

  closest_pos = starting_positions.min_by { |pos| step_memo[pos[1]][pos[0]] || 999999999 }
  puts step_memo[closest_pos[1]][closest_pos[0]]
end

def grid_string(grid, step_memo)
  grid.map.with_index { |row, y| row.map.with_index { |c, x| "#{c}:#{step_memo[y][x]}" || "0" }.join(",") }.join("\n")
end

def climbable_elevation?(current_elev, new_elev)
  ELEVATION_VALUES[new_elev] - ELEVATION_VALUES[current_elev] >= -1
end

def find_pos(grid, char)
  [].tap do |pos|
    grid.each.with_index do |row, y|
      row.each.with_index do |c, x|
        if c == char
          pos << [x, y]
        end
      end
    end
  end
end

def explore_neighbors(grid, x, y, step_memo)
  return step_memo if grid[y][x] == 'a'
  up_neighbor = neighbor(grid, x, y, UP)
  down_neighbor = neighbor(grid, x, y, DOWN)
  left_neighbor = neighbor(grid, x, y, LEFT)
  right_neighbor = neighbor(grid, x, y, RIGHT)

  next_nodes = []

  if right_neighbor && climbable_elevation?(grid[y][x], right_neighbor)
    next_nodes << [x + RIGHT[0], y + RIGHT[1]]
  end

  if down_neighbor && climbable_elevation?(grid[y][x], down_neighbor)
    next_nodes << [x + DOWN[0], y + DOWN[1]]
  end

  if left_neighbor && climbable_elevation?(grid[y][x], left_neighbor)
    next_nodes << [x + LEFT[0], y + LEFT[1]]
  end

  if up_neighbor && climbable_elevation?(grid[y][x], up_neighbor)
    next_nodes << [x + UP[0], y + UP[1]]
  end

  current_steps = step_memo[y][x]
  next_nodes.each do |node|
    next_steps = step_memo[node[1]][node[0]]
    if next_steps == nil || current_steps + 1 < next_steps
      step_memo[node[1]][node[0]] = current_steps + 1
      explore_neighbors(grid, node[0], node[1], step_memo)
    end
  end

  step_memo
end

def neighbor(grid, x, y, dir)
  new_x = x + dir[0]
  new_y = y + dir[1]

  allowed_y = (0...grid.count)
  allowed_x = (0...grid[0].count)
  grid[new_y][new_x] if allowed_x.include?(new_x) && allowed_y.include?(new_y)
end

main if __FILE__ == $PROGRAM_NAME
