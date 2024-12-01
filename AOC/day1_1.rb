# frozen_string_literal: true

file_path = 'input/day1.txt'
# r is readmode
file = File.open(file_path, 'r')

input = <<~INPUT
32323   4356
4   3
2   5
1   3
3   9
3   3
INPUT


touples = []
array1 = []
array2 = []
result = []

file.map do |line|
  line = line.split(' ')
  array1 << line[0]
  array2 << line[1]
end
file.close

array1.map!(&:to_i).sort!
array2.map!(&:to_i).sort!
touples = [array1, array2].transpose

touples.map do |a,b|
  result << (a-b).abs
end

puts result.sum
