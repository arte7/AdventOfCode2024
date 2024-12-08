# frozen_string_literal: true
require 'pry'
file_path = 'input/day3.txt'
# r is readmode
file = File.open(file_path, 'r')

input = <<~INPUT
xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))
INPUT

array = []
result = []
find_do = []
findings = []
find_all = []

line = file.read
file.close

find_all << line.split(/do\(\)/)

find_all.flatten.each do |line|
  find_do << line.split(/don't\(\)/,2)[0]
end

find_do.flatten.map do |finding|
  findings << finding.scan(/mul\([0-9]{1,3}\,[0-9]{1,3}\)/)
end

findings.flatten.map do |i|
  array << i[4..-2].split(",").map(&:to_i)
end

array.each do |a,b|
  result << (a*b)
end

puts result.sum
