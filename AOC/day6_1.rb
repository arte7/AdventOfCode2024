# frozen_string_literal: true
require 'pry'

file_path = 'input/day6.txt'
# r is readmode
file = File.open(file_path, 'r')

input = <<~INPUT
....#.....
.........#
..........
..#.......
.......#..
..........
.#..^.....
........#.
#.........
......#...
INPUT

result = []
matrix = []
p1 = 0
p2 = 0
steps = 0
count = 0

file.each_line do |line|
  matrix << line.strip.split('')
end
file.close

len = matrix.length
puts "len: #{len}"

for i in 0...len do
  for j in 0...len do
    if matrix[i][j] == "^"
      p1=i
      p2=j
      puts "start coordinates i:#{p1}, j:#{p2}"
      # turn coordinates left
      p2 = (len-1-i)
      p1 = j
      puts "transposed coordinates i:#{p1}, j:#{p2}"
    end
  end
end

go_forward = Proc.new do |p2|
  for j in (p2)..(len+1) do
    if matrix[p1][j+1] == "." || matrix[p1][j+1] == "X"
      matrix[p1][j] = "X"
      steps+=1
    elsif matrix[p1][j+1] == "#"
      # trun coordinates right
      p2 = p1
      p1 = (len-1-j)
      # turn matrix left
      matrix = matrix.transpose.reverse
      matrix[p1][p2] = "X"
      go_forward.call(p2)
    elsif matrix[p1][j+1] == nil
      matrix[p1][j] = "X"
      puts "steps until end #{steps}"
      matrix.each do |line|
        count += line.count("X")
      end
      puts "X count at the end #{count}"
      return
    else
      puts "some unknown eror"
    end
  end
end

# turn right only first time, the rest of the time turn left
matrix = matrix.reverse.transpose

while matrix[p1][p2] != nil
  go_forward.call(p2)
end
