def main
  cycle = 1
  x = 1
  crt = ""
  File.foreach('./input.txt').map(&:strip).each do |instruction|
    if instruction == 'noop'
      cycle, crt = tick(x, cycle, crt)
    else
      val = instruction.split.last.to_i
      cycle, crt = tick(x, cycle, crt)
      cycle, crt = tick(x, cycle, crt)
      x += val
    end
  end
  puts crt
end

def tick(x, cycle, crt)
  if (x - 1..x + 1).include?((cycle - 1) % 40)
    crt << "#"
  else
    crt << "."
  end
  crt << "\n" if cycle % 40 == 0
  cycle += 1
  [cycle, crt]
end

main if __FILE__ == $PROGRAM_NAME
