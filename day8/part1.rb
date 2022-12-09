# frozen_string_literal: true
def main
  grid = File.open('./input.txt').readlines.map(&:strip).map { |line| line.chars.map(&:to_i) }
  visible = grid.each.with_index.sum do |row, y|
    row.each.with_index.count do |_, x|
      edge?(x, y, grid) ||
        visible_from_west?(x, y, grid) ||
        visible_from_north?(x, y, grid) ||
        visible_from_east?(x, y, grid) ||
        visible_from_south?(x, y, grid)
    end
  end
  puts visible
end

def edge?(x, y, grid)
  x == 0 || y == 0 || x == grid[0].length - 1 || y == grid.length - 1
end

def visible_from_west?(x, y, grid)
  (0...x).all? do |other_x|
    grid[y][other_x] < grid[y][x]
  end
end

def visible_from_east?(x, y, grid)
  ((x+1)...grid[0].length).to_a.reverse.all? do |other_x|
    grid[y][other_x] < grid[y][x]
  end
end

def visible_from_north?(x, y, grid)
  (0...y).all? do |other_y|
    grid[other_y][x] < grid[y][x]
  end
end

def visible_from_south?(x, y, grid)
  ((y+1)...grid.length).to_a.reverse.all? do |other_y|
    grid[other_y][x] < grid[y][x]
  end
end

main if __FILE__ == $PROGRAM_NAME
