# frozen_string_literal: true
def main
  input = File.read('./input.txt').strip
  puts detect_start_of_packet(input.chars)
end

def detect_start_of_packet(stream)
  candidates = stream.shift(4)
  pos = 4

  until candidates.uniq.count == 4 do
    candidates.shift
    candidates << stream.shift
    pos += 1
  end

  pos
end

main if __FILE__ == $PROGRAM_NAME
