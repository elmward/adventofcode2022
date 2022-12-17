# frozen_string_literal: true
def main
  monkeys = []
  File.open('./input.txt').read.split("\n\n").reduce(monkeys) do |monkeys, monkey_input|
    monkey = {}
    monkey[:items] = get_items(monkey_input)
    monkey[:operation] = get_operation(monkey_input)
    monkey[:test] = get_test(monkey_input)
    monkey[:inspections] = 0
    monkeys << monkey
  end

  20.times do
    monkeys.each do |monkey|
      until monkey[:items].empty? do
        monkey[:inspections] += 1
        worry_level = monkey[:items].shift
        if monkey[:operation][1] != 'old'
          worry_level = worry_level.send(monkey[:operation][0], monkey[:operation][1])
        else
          worry_level = worry_level.send(monkey[:operation][0], worry_level)
        end
        worry_level /= 3
        if worry_level % monkey[:test][0] == 0
          monkeys[monkey[:test][1]][:items] << worry_level
        else
          monkeys[monkey[:test][2]][:items] << worry_level
        end
      end
    end
  end

  puts monkeys.map { |m| m[:inspections] }.sort.last(2).reduce(&:*)
end

def get_items(input)
  item_string = /Starting items: (.*)/.match(input)[1]
  item_string.split(', ').map(&:to_i)
end

def get_operation(input)
  op, other = /Operation: new = old (.) (.*)/.match(input)[1..2]
  op = op.to_sym
  other = other.to_i unless other == 'old'
  [op, other]
end

def get_test(input)
  test, true_op, false_op = input.split("\n")[3..5]
  modulo = /Test: divisible by (\d+)/.match(test)[1].to_i
  true_target = /If true: throw to monkey (\d+)/.match(true_op)[1].to_i
  false_target = /If false: throw to monkey (\d+)/.match(false_op)[1].to_i
  [modulo, true_target, false_target]
end

main if __FILE__ == $PROGRAM_NAME
