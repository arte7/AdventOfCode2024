# frozen_string_literal: true
require 'benchmark'

file_path = 'input/day1_1.txt'
# r is readmode
file = File.open(file_path, 'r')

input = <<~INPUT
3   4
4   3
2   5
1   3
3   9
3   3
INPUT

time = Benchmark.measure do
result = []
array1 = []
array2 = []

file.each_line do |line|
  line = line.split(' ')
  array1 << line[0]
  array2 << line[1]
end
file.close

array1.map!(&:to_i).sort!
array2.map!(&:to_i).sort!
array1.map do |a|
  multiplicator = array2.count(a)
  result << a * multiplicator
end
puts result.sum

end
puts time
