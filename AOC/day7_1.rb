# frozen_string_literal: true
require 'pry'


file_path = 'input/day7.txt'
# r is readmode
file = File.open(file_path, 'r')

input = <<~INPUT
190: 10 19
3267: 81 40 27
83: 17 5
156: 15 6
7290: 6 8 6 15
161011: 16 10 13
192: 17 8 14
21037: 9 7 18 13
292: 11 6 16 20
INPUT

result = []
operators = []
binaries = []
sum = 0

calculate_binaries = Proc.new do |len|
  binaries.clear
  max_num = 0
  for i in 0...len-1
    max_num += (2**i)
  end
  puts "max_num #{max_num}"

  for i in 1...max_num
    binaries << ("%0#{len-1}b" % i).reverse
  end
  puts "binaries #{binaries}"
  binaries
end

file.each_line do |line|
  e = line.split(": ")
  test_value = e[0].to_i
  numbers = e[1].split(" ").map(&:to_i)

  puts "new line hurray--------------#{numbers}"
  multiply_all = 1
  numbers.each do |num|
    multiply_all *= num.to_i
  end

  add_all = 0
  numbers.each do |num|
    add_all += num
  end

  # check early exit before calculating the operators variations
  if add_all > test_value || multiply_all < test_value
    puts "early exit: add_all or multiply_all too big or small: add #{add_all}, multi #{multiply_all} test_value: #{test_value}"
    next
  elsif add_all == test_value || multiply_all == test_value
    puts "early exit: add_all or multiply_all fits: add #{add_all}, multi #{multiply_all} test_value: #{test_value}"
    result << test_value
  end

  len = numbers.length
  puts "len #{len}"
  calculate_binaries.call(len)

  if len > 2
    puts "loop time"
    i = 0
    bin_len = binaries.length
    end_value = 0
    while end_value != test_value && i < bin_len
    interim_numbers = []
      interim_numbers << numbers
      interim_numbers.flatten!
      puts "iinterim_numbers; #{interim_numbers}"

      for j in 0...len-1
        bin = binaries[i][j]
        if bin == "0"
          puts "here comes stuff in addition"
          new_num = (interim_numbers.slice!(0) + interim_numbers.slice!(0))
          interim_numbers.prepend(new_num)
        elsif bin == "1"
          puts "here comes stuff in multiplication"
          new_num = (interim_numbers.slice!(0) * interim_numbers.slice!(0))
          interim_numbers.prepend(new_num)
        else
          "there must be some error with the binaries"
        end
      end
      if interim_numbers.length == 1
        end_value = interim_numbers[0]
        puts "end_value #{end_value}"
        puts "test_value #{test_value}"

        if end_value == test_value
          result << end_value
          puts "its matching"
          next
        end
      end
      i += 1
    end
  else
    next
  end
end

puts operators
print result
puts "\n sum = #{result.sum}"

file.close
