# frozen_string_literal: true

def priorities
  @priorities ||= {}
  if @priorities.empty?
    ('a'..'z').to_a.map.with_index { |c, i| @priorities[c] = i + 1 }
    ('A'..'Z').to_a.map.with_index { |c, i| @priorities[c] = i + 27 }
  end
  @priorities
end

def main
  puts(File.readlines('./input.txt').map(&:strip).reduce(0) do |acc, line|
    first = line.chars[0..(line.chars.count / 2) - 1]
    second = line.chars[(line.chars.count / 2)..]
    repeat = second.detect { |c| first.include?(c) }
    acc + priorities[repeat]
  end)
end

main if __FILE__ == $PROGRAM_NAME
