# frozen_string_literal: true

CRATE_POSITIONS = {
  1 => 0,
  5 => 1,
  9 => 2,
  13 => 3,
  17 => 4,
  21 => 5,
  25 => 6,
  29 => 7,
  33 => 8
}

def main
  input = File.read('./input.txt')
  initial_state, directions = input.split("\n\n")
  stacks = load_stacks(initial_state)
  stacks = follow_directions(stacks, directions)
  puts stacks.map(&:last).join
end

def load_stacks(initial_state)
  [[], [], [], [], [], [], [], [], []].tap do |stacks|
    initial_state = initial_state.split("\n")[0...-1]
    initial_state.reverse.each do |row|
      CRATE_POSITIONS.each do |position, column|
        stacks[column] << row[position] unless row[position] == ' '
      end
    end
  end
end

def follow_directions(stacks, directions)
  directions.split("\n").each do |direction|
    num, from, to = /move (\d+) from (\d) to (\d)/.match(direction)[1..3].map(&:to_i)
    num.times do
      stacks[to - 1].push(stacks[from - 1].pop)
    end
  end

  stacks
end

main if __FILE__ == $PROGRAM_NAME
