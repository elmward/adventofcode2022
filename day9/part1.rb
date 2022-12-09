# frozen_string_literal: true
require 'set'

def main
  directions = File.readlines('./input.txt').map(&:strip)
  head_pos = [0, 0]
  tail_pos = [0, 0]
  visited = Set.new

  directions.each do |direction|
    dir, num = direction.split
    num.to_i.times do
      case dir
      when 'R'
        head_pos[0] += 1
      when 'L'
        head_pos[0] -= 1
      when 'U'
        head_pos[1] += 1
      when 'D'
        head_pos[1] -= 1
      end
      move_tail(head_pos, tail_pos)
      visited << tail_pos
    end
  end
  puts visited.count
end

def move_tail(head_pos, tail_pos)
  return if touching?(head_pos, tail_pos)

  if head_pos[0] == tail_pos[0]
    tail_pos[1] < head_pos[1] ? tail_pos[1] += 1 : tail_pos[1] -= 1
  elsif head_pos[1] == tail_pos[1]
    tail_pos[0] < head_pos[0] ? tail_pos[0] += 1 : tail_pos[0] -= 1
  else
    if head_pos[0] > tail_pos[0]
      tail_pos[0] += 1
    else
      tail_pos[0] -= 1
    end

    if head_pos[1] > tail_pos[1]
      tail_pos[1] += 1
    else
      tail_pos[1] -= 1
    end
  end
  tail_pos
end

def touching?(head_pos, tail_pos)
  (head_pos[0] - tail_pos[0]).abs <= 1 && (head_pos[1] - tail_pos[1]).abs <= 1
end

main if __FILE__ == $PROGRAM_NAME
