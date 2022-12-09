# frozen_string_literal: true
def main
  grid = File.open('./input.txt').readlines.map(&:strip).map { |line| line.chars.map(&:to_i) }
  best_score = grid.map.with_index do |row, y|
    row.map.with_index do |_, x|
      scenic_score(x, y, grid)
    end
  end.flatten.max
  puts best_score
end

def scenic_score(x, y, grid)
  west_score(x, y, grid) *
    north_score(x, y, grid) *
    east_score(x, y, grid) *
    south_score(x, y, grid)
end

def west_score(x, y, grid)
  score = 0
  other_x = x - 1
  until other_x < 0 || grid[y][other_x] >= grid[y][x] do
    score += 1
    other_x -= 1
  end
  score += 1 unless other_x < 0
  score
end

def east_score(x, y, grid)
  score = 0
  other_x = x + 1
  until other_x >= grid[0].length || grid[y][other_x] >= grid[y][x] do
    score += 1
    other_x += 1
  end
  score += 1 unless other_x >= grid[0].length
  score
end

def north_score(x, y, grid)
  score = 0
  other_y = y - 1
  until other_y < 0 || grid[other_y][x] >= grid[y][x] do
    score += 1
    other_y -= 1
  end
  score += 1 unless other_y < 0
  score
end

def south_score(x, y, grid)
  score = 0
  other_y = y + 1
  until other_y >= grid.length || grid[other_y][x] >= grid[y][x] do
    score += 1
    other_y += 1
  end
  score += 1 unless other_y >= grid.length
  score
end

main if __FILE__ == $PROGRAM_NAME
