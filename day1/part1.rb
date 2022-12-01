def main
  input = File.open('./input.txt').read
  elves = input.split("\n\n")
  puts elves.map { |elf| elf.split("\n").map(&:to_i).sum }.max
end

if __FILE__ == $PROGRAM_NAME
    main
end
