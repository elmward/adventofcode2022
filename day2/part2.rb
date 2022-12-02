MOVE_VALUES = {
  'A' => 1,
  'B' => 2,
  'C' => 3
}

WINNING_MOVES = {
  'A' => 'B',
  'B' => 'C',
  'C' => 'A'
}

LOSING_MOVES = {
  'A' => 'C',
  'B' => 'A',
  'C' => 'B'
}

def rps(opponent_move, my_move)
  if my_move == WINNING_MOVES[opponent_move]
    6
  elsif my_move == opponent_move
    3
  else
    0
  end
end

def main
  moves = File.open('./input.txt').readlines.map(&:strip)
  puts(moves.reduce(0) do |score, move|
    opponent_move, result = move.split(' ')
    my_move = case result
              when 'X'
                LOSING_MOVES[opponent_move]
              when 'Y'
                opponent_move
              when 'Z'
                WINNING_MOVES[opponent_move]
              end
    score + MOVE_VALUES[my_move] + rps(opponent_move, my_move)
  end)
end

main if __FILE__ == $PROGRAM_NAME
