# frozen_string_literal: true

file_path = 'input/day5.txt'
# r is readmode
file = File.open(file_path, 'r')

input = <<~INPUT
47|53
97|13
97|61
97|47
75|29
61|13
75|53
29|13
97|29
53|29
61|53
97|53
61|29
47|13
75|47
97|75
47|61
75|61
47|29
75|13
53|13

75,47,61,53,29
97,61,53,29,13
75,29,13
75,97,47,61,53
61,13,29
97,13,75,29,47
INPUT

result = []
bigger_than = {}
directions = []
e = []

# e = file.read.split(/\n\n/)
e = input.split(/\n\n/)

file.close

e[0].split(/\n/).each do |i|
  tup = i.split(/\|/).map(&:to_i)
  (bigger_than[tup[0]] ||= []) <<(tup[1])
end

e[1].split(/\n/).each do |i|
  directions << i.split(",").map(&:to_i)
end

directions.each do |line|
  len = line.length-1
  mid = len/2

  for i in 0...len do
    if bigger_than[line[i]].nil?
      break
    elsif bigger_than[line[i]].include?(line[i+1]) && ((i+1) == len)
      print line
      result << line[mid]
    elsif bigger_than[line[i]].include?(line[i+1])
    else
      break
    end
  end
end

puts result.sum
