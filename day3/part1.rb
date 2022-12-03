# frozen_string_literal: true
ALL_ITEMS = [].concat(('a'..'z').to_a).concat(('A'..'Z').to_a)
PRIORITIES = ALL_ITEMS.each.with_index.each_with_object({}) do |(c, i), priorities|
  priorities[c] = i + 1
end

def main
  puts(File.readlines('./input.txt').map(&:strip).reduce(0) do |acc, line|
    first = line.chars[0..(line.chars.count / 2) - 1]
    second = line.chars[(line.chars.count / 2)..]
    repeat = second.detect { |c| first.include?(c) }
    acc + PRIORITIES[repeat]
  end)
end

main if __FILE__ == $PROGRAM_NAME
