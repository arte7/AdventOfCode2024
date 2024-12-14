# frozen_string_literal: true
require 'pry'

file_path = 'input/day6.txt'
# r is readmode
file = File.open(file_path, 'r')

input = <<~INPUT
....#.........#.....
.........#.........#
....................
..#.........#.......
.......#.........#..
....................
.#..^......#........
........#.........#.
#.........#.........
......#.........#...
....#.........#.....
.........#.........#
....................
..#.........#.......
.......#.........#..
....................
.#.........#........
........#.........#.
#.........#.........
......#.........#...
INPUT

result = []
matrix = []
p1 = 0
p2 = 0
steps = 0
count = 0

input.each_line do |line|
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
      # turn coordinates right
      p2 = (len-1-i)
      p1 = j
      puts "transposed coordinates i:#{p1}, j:#{p2}"
    end
  end
end

find_loops = Proc.new do

end

go_forward = Proc.new do |p2|
  for j in (p2)..(len+1) do
    if matrix[p1][j+1] == "." || matrix[p1][j+1] == "+"
      matrix[p1][j] = "+"
      steps+=1
    elsif matrix[p1][j+1] == "#"
      matrix[p1][p2] = "X"
      # trun coordinates left
      p2 = p1
      p1 = (len-1-j)
      # turn matrix left
      matrix = matrix.transpose.reverse
      go_forward.call(p2)
    elsif matrix[p1][j+1] == nil
      matrix[p1][j] = "+"
      print matrix
      puts ""
      return
      find_loops.call
    else
      puts "some unknown eror"
    end
  end
end

# turn right only first time, the rest of the time turn left
matrix = matrix.reverse.transpose

print matrix
puts "start"

while matrix[p1][p2] != nil
  go_forward.call(p2)
end

puts "after break"


# 1. geradeaus laufen
