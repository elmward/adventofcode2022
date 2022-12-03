# frozen_string_literal: true

ALL_ITEMS = [].concat(('a'..'z').to_a).concat(('A'..'Z').to_a)
PRIORITIES = ALL_ITEMS.each.with_index.each_with_object({}) do |(c, i), priorities|
  priorities[c] = i + 1
end

def main
  puts(File.readlines('./input.txt').map(&:strip).each_slice(3).reduce(0) do |acc, group|
    badge = ALL_ITEMS.detect { |c| group[0].include?(c) && group[1].include?(c) && group[2].include?(c) }
    acc + PRIORITIES[badge]
  end)
end

main if __FILE__ == $PROGRAM_NAME
