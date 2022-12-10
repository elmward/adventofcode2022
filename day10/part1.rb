# frozen_string_literal: true
def main
  cycle = 1
  x = 1
  sum_of_interesting_values = 0
  File.readlines('./input.txt').map(&:strip).each do |instruction|
    if instruction == 'noop'
      cycle, sum_of_interesting_values = tick(x, cycle, sum_of_interesting_values)
    else
      val = instruction.split.last.to_i
      cycle, sum_of_interesting_values = tick(x, cycle, sum_of_interesting_values)
      cycle, sum_of_interesting_values = tick(x, cycle, sum_of_interesting_values)
      x += val
    end
  end
  puts sum_of_interesting_values
end

def tick(x, cycle, sum_of_interesting_values)
  if (cycle - 20) % 40 == 0
    sum_of_interesting_values += cycle * x
  end
  cycle += 1
  [cycle, sum_of_interesting_values]
end

main if __FILE__ == $PROGRAM_NAME
