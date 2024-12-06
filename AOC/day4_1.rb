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

array = []
matrix = []
count = 0

file.each_line do |line|
  array << line.strip
  matrix << line.strip.split('')
end
file.close

find_in_line = Proc.new do |e|
  e.map do |line|
    occurences = line.scan(/XMAS/).count
    count += occurences
  end
end

reverse = Proc.new do |old_matrix|
  new_matrix = []
  old_matrix.each do |line|
    new_matrix << line.reverse
  end
  new_matrix
end

find_diagonal = Proc.new do |m|
  len = matrix.length

  for i in 0...len-3 do
    for j in 0...len-3 do
      if m[i][j]== "X" && m[i+1][j+1] == "M" && m[i+2][j+2] == "A" && m[i+3][j+3] == "S"
        count += 1
      end
    end
  end
end

find_in_line.call(array)
find_diagonal.call(matrix)
# 1st flip right
reversed_matrix = reverse.call(matrix)
find_in_line.call(reversed_matrix.map(&:join))
transposed_matrix = reversed_matrix.transpose
find_in_line.call(transposed_matrix.map(&:join))
find_diagonal.call(transposed_matrix)
# 2nd flip right
reversed_matrix = reverse.call(transposed_matrix)
find_in_line.call(reversed_matrix.map(&:join))
transposed_matrix = reversed_matrix.transpose
find_diagonal.call(transposed_matrix)
# 3rd flip right
reversed_matrix = reverse.call(transposed_matrix)
transposed_matrix = reversed_matrix.transpose
find_diagonal.call(transposed_matrix)

puts "total #{count}"
