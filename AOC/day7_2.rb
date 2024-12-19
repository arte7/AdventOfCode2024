# frozen_string_literal: true
require 'pry'


file_path = 'input/day7.txt'
# r is readmode
file = File.open(file_path, 'r')

input = <<~INPUT
190: 10 19
3267: 81 40 27
83: 17 5
156: 15 6
7290: 6 8 6 15
161011: 16 10 13
192: 17 8 14
21037: 9 7 18 13
292: 11 6 16 20
INPUT

result = []

def get_operators(len)
  a = [:+, :*, :c]
  b = a.repeated_permutation(len).to_a
end

def calculate(numbers, operators)
  acc = numbers[0]
  operators.each_with_index do |op, idx|
    if op == :c
      acc = "#{acc}#{numbers[idx+1]}".to_i
    else
      acc = numbers[idx+1].send(op, acc)
    end
  end
  acc
end


file.each_line do |line|
  e = line.split(":")
  test_value = e[0].to_i
  numbers = e[1].split(" ").map(&:to_i)

  len = numbers.length
  operators = get_operators(len-1)
  acc = 0

  operators.each do |ops|
    acc = calculate(numbers, ops)
    if acc == test_value
      result << test_value.to_int
      break
    end
  end
end

puts "result = #{result.sum}"

file.close
