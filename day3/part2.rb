# frozen_string_literal: true

ALL_ITEMS = [].concat(('a'..'z').to_a).concat(('A'..'Z').to_a)

def priorities
  @priorities ||= {}
  if @priorities.empty?
    ('a'..'z').to_a.map.with_index { |c, i| @priorities[c] = i + 1 }
    ('A'..'Z').to_a.map.with_index { |c, i| @priorities[c] = i + 27 }
  end
  @priorities
end

def main
  puts(File.readlines('./input.txt').map(&:strip).each_slice(3).reduce(0) do |acc, group|
    badge = ALL_ITEMS.detect { |c| group[0].include?(c) && group[1].include?(c) && group[2].include?(c) }
    acc + priorities[badge]
  end)
end

main if __FILE__ == $PROGRAM_NAME
