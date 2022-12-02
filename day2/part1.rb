MOVE_VALUES = {
  'X' => 1,
  'Y' => 2,
  'Z' => 3
}

WINNING_MOVES = {
  'A' => 'Y',
  'B' => 'Z',
  'C' => 'X'
}

EQUIVALENT_MOVES = {
  'A' => 'X',
  'B' => 'Y',
  'C' => 'Z'
}

def rps(opponent_move, my_move)
  if my_move == WINNING_MOVES[opponent_move]
    6
  elsif my_move == EQUIVALENT_MOVES[opponent_move]
    3
  else
    0
  end
end

def main
  moves = File.open('./input.txt').readlines.map(&:strip)
  puts(moves.reduce(0) do |score, move|
    opponent_move, my_move = move.split(' ')
    score + MOVE_VALUES[my_move] + rps(opponent_move, my_move)
  end)
end

main if __FILE__ == $PROGRAM_NAME
