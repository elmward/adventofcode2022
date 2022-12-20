# frozen_string_literal: true
require 'set'

def main
  rocks = build_cave
  lowest_y = rocks.to_a.max_by { |pt| pt[1] }[1]

  i = 0
  pos = [500, 0]
  until pos[1] >= lowest_y
    pos = drop_sand(rocks, lowest_y)
    i += 1
  end

  puts i - 1
end

def build_cave
  Set.new.tap do |rocks|
    File.foreach('./input.txt') do |line|
      line.split(' -> ').map { |pair_string| pair_string.split(',').map(&:to_i) }.each_cons(2) do |point_a, point_b|
        if point_a[0] == point_b[0]
          start_y, end_y = [point_a[1], point_b[1]].sort
          (start_y..end_y).each do |y|
            rocks << [point_a[0], y]
          end
        else
          start_x, end_x = [point_a[0], point_b[0]].sort
          (start_x..end_x).each do |x|
            rocks << [x, point_a[1]]
          end
        end
      end
    end
  end
end

def drop_sand(rocks, lowest_y)
  pos = [500, 0]

  done = false

  until done
    if pos[1] >= lowest_y
      done = true
    elsif !rocks.include?([pos[0], pos[1] + 1])
      pos[1] += 1
    elsif !rocks.include?([pos[0] - 1, pos[1] + 1])
      pos[0] -= 1
      pos[1] += 1
    elsif !rocks.include?([pos[0] + 1, pos[1] + 1])
      pos[0] += 1
      pos[1] += 1
    else
      rocks << pos
      done = true
    end
  end

  pos
end

main if __FILE__ == $PROGRAM_NAME
