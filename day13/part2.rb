# frozen_string_literal: true

def main
  packets = File.open('./input.txt').read.gsub("\n\n", "\n").split.map { |line| eval(line) }
  packets << [[2]]
  packets << [[6]]
  packets.sort! { |a, b| ordering(a, b) }
  puts (packets.find_index([[2]]) + 1) * (packets.find_index([[6]]) + 1)
end

def ordering(a, b)
  if a.instance_of?(Integer) && b.instance_of?(Integer)
    return a <=> b
  elsif a.instance_of?(Array) && b.instance_of?(Integer)
    b = [b]
  elsif a.instance_of?(Integer) && b.instance_of?(Array)
    a = [a]
  end

  return -1 if a.empty? && !b.empty?
  return 0 if [a, b].all?(&:empty?)
  return 1 if b.empty? && !a.empty?

  ordering = ordering(a.first, b.first)
  return ordering unless ordering == 0

  ordering(a[1..], b[1..])
end

main if __FILE__ == $PROGRAM_NAME
