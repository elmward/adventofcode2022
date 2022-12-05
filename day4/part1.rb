# frozen_string_literal: true

def main
  lines = File.readlines('./input.txt').map(&:strip)
  ranges = lines.map { |line| line.split(',').map { |range| range.split('-').map(&:to_i) } }
  overlaps = ranges.count do |first_range, second_range|
    (first_range[0] >= second_range[0] && first_range[1] <= second_range[1]) ||
      (first_range[0] <= second_range[0] && first_range[1] >= second_range[1])
  end
  puts overlaps
end

main if __FILE__ == $PROGRAM_NAME
