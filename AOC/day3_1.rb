# frozen_string_literal: true
require 'bigdecimal'

file_path = 'input/day3.txt'
# r is readmode
file = File.open(file_path, 'r')

input = <<~INPUT
xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))
INPUT

array = []
findings = []
result = []
sum = 0

file.each_line do |line|
  findings << line.scan(/mul\([0-9]{,3}\,[0-9]{,3}\)/)
end
file.close

findings.flatten.map do |i|
  array << i[4..-2].split(",").map(&:to_i)
end

array.each do |a,b|
  result << (a*b)
end

puts result.sum
