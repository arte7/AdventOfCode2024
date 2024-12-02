# frozen_string_literal: true

file_path = 'input/day2.txt'
# r is readmode
file = File.open(file_path, 'r')

input = <<~INPUT
7 6 4 2 1
1 2 7 8 9
9 7 6 2 1
1 3 2 4 5
8 6 4 4 1
1 3 6 7 9
INPUT

result = []

file.each_line do |line|
  stage = []
  e = line.split(' ').map!(&:to_i)
  sorted = e.sort

  if e != sorted && e != sorted.reverse
  else
    for i in 0..e.length-2 do
      distance = (e[i].to_i - e[i+1].to_i).abs
      if distance < 1 || distance > 3
        stage << false
      else
        stage << true
      end
    end
    if stage.all?
      result << "1"
    end
  end
end
file.close
puts result.count
