# frozen_string_literal: true

def main
  pairs = File.open('./input.txt').read.split("\n\n").map { |pair_string| pair_string.split("\n").map { |packet| eval(packet) } }
  puts pairs.map.with_index(1) { |pair, i| i if ordering(pair[0], pair[1]) == -1 }.reject(&:nil?).sum
end

def ordering(a, b)
  if a.instance_of?(Integer) && b.instance_of?(Integer)
    return a <=> b
  elsif a.instance_of?(Array) && b.instance_of?(Integer)
    b = [b]
  elsif a.instance_of?(Integer) && b.instance_of?(Array)
    a = [a]
  end

  if a.instance_of?(Array) && b.instance_of?(Array)
    return -1 if a.empty? && !b.empty?
    return 0 if [a, b].all?(&:empty?)
    return 1 if b.empty? && !a.empty?
  end

  first_a = a.shift
  first_b = b.shift

  ordering = ordering(first_a, first_b)
  return ordering unless ordering == 0

  ordering(a, b)
end

main if __FILE__ == $PROGRAM_NAME
