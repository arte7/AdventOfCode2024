# frozen_string_literal: true

file_path = 'input/day4.txt'
# r is readmode
file = File.open(file_path, 'r')

input = <<~INPUT
MMMSXXMASM
MSAMXMSMSA
AMXSXMAAMM
MSAMASMSMX
XMASAMXAMM
XXAMMXXAMA
SMSMSASXSS
SAXAMASAAA
MAMMMXMMMM
MXMXAXMASX
INPUT

matrix = []
count = 0

file.each_line do |line|
  matrix << line.strip.split('')
end
file.close

flip_right = Proc.new do |matrix|
  matrix.reverse.transpose
end

find_x = Proc.new do |m|
  len = matrix.length

  for i in 0...len-2 do
    for j in 0...len-2 do
      if m[i][j]== "M" && m[i+1][j+1] == "A" && m[i+2][j+2] == "S" && m[i][j+2] == "M" && m[i+2][j] == "S"
        count += 1
      end
    end
  end
end


find_x.call(matrix)
find_x.call(flip_right.call(matrix))
find_x.call(flip_right.call(flip_right.call(matrix)))
find_x.call(flip_right.call(flip_right.call(flip_right.call(matrix))))

puts ""
puts "total #{count}"
