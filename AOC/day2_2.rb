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
1 5 7 8 9
INPUT

result = []
success_count = 0
eliminated_count = 0
errors = 0

file.each_line do |line|
  fails = 0
  e = line.split(' ').map!(&:to_i)
  unique = e.uniq

  while fails < 2
    # when there are more than 2 duplicates
    if e.length - unique.length >= 2
      puts "there are more than 2 duplicates, it fails"
      fails += 2
      eliminated_count += 1
      break
      # when there are 0 or 1 duplicates and the array is sorted
    elsif e.sort == e || e.sort.reverse == e || unique.sort == unique || unique.sort.reverse == unique
      puts "the array is sorted"
      if e.length - unique.length == 1
        fails += 1
      end

      # an array with 0 or 1 duplicates as unique are the same
      for i in 0..unique.length-2 do
        distance = (unique[i].to_i - unique[i+1].to_i).abs
        if distance > 3
          puts "and the distance is greater than 3, it adds a fail"
          fails += 1
        end
      end

      if fails < 2
        success_count += 1
        result << true
        break
      elsif fails >= 2
        eliminated_count += 1
        break
      end
      # there are 1 duplicates and the array is not sorted (probablythe last part of the condition can be deleted)
    elsif e.length - unique.length == 1 && (unique.sort != unique || unique.sort.reverse != unique)
      puts "there are 1 duplicates and the array is not sorted"
      eliminated_count += 1
      fails += 2
      break
      # when there are no duplicates and the array is not sorted
    elsif e.length - unique.length == 0 && (unique.sort != unique || unique.sort.reverse != unique)
      outliers = []
      end_index = [e.length - 1]
      puts "there are no duplicates and the array is not sorted"
      for i in 0..e.length-2 do
        distance = (e[i].to_i - e[i+1].to_i).abs
        if distance > 3
          puts 'distance greater than 3'
          fails += 1
          if i == 0
            puts "add outlier 0"
            outliers << 0
          else
            puts "add outlier"
            outliers << (i+1)
          end
        end
      end

      if outliers.empty?
        pos = []
        neg = []
        end_of_array = e.length - 1
      # not sorted no outliers is not save
        print e
        puts "outliers empty, here be dragons"

        for i in 0..e.length-2 do
          if e[i] < e[i+1]
            pos << i
          else
            neg << i
          end
        end

        if pos.length == 1 && pos[0] == (end_of_array-1)
          puts "delete at pos 0-1"
          e.delete_at(pos[0]+1)
          print e
        elsif pos.length == 1 && pos[0] == 0
          puts "delete at pos 0"
          e.delete_at(0)
          print e
        elsif neg.length == 1 && neg[0] == (end_of_array-1)
          puts "delete at neg"
          e.delete_at(neg[0]+1)
          print e
        elsif neg.length == 1 && neg[0] == 0
          puts "delete at pos 0"
          e.delete_at(0)
          print e
        elsif pos.length > 1 || neg.length > 1
          puts "more than 1 in wrong directon"
          print e
          eliminated_count += 1
          break
        else
          puts "this might be a false negative or positive"
          print e
          errors += 1
        end

        for i in 0..e.length-2 do
          distance = (e[i].to_i - e[i+1].to_i).abs
          if distance > 3
            puts "in outliers empty and the distance is greater than 3, it adds a fail"
            print e
            puts "distance #{distance}"
            fails += 1
          end
        end

        if fails < 1
          success_count += 1
          result << true
          break
        elsif fails >= 1
          eliminated_count += 1
          break
        end
      elsif outliers == end_index || outliers == [0]
        puts "end or beginning save outliers"
        result << true
        success_count += 1
        break
        # outliers next to each other
      elsif outliers.length == 2 && (outliers[0]-outliers[1]).abs == 1
        puts "outliers next to each other"
        # checks if numbers left and right have distance less or equal 3
        if e[outliers[0]-1] - e[outliers[0]+1] <= 3
          puts "save outliers"
          result << true
          success_count += 1
        else
          puts "outliers not safe"
          eliminated_count += 1
        end
        break
      elsif outliers.length >=2
        puts "outliers greater equal 2 not safe"
        eliminated_count += 1
        break
      elsif outliers.length == 1
      # distance between fields next to outlier is less or equal 3
        puts "one outlier"
        if e[outliers[0]-1] - e[outliers[0]+1] <= 3
          puts "number before and after outlier have distance less or equal 3"
          result << true
          success_count += 1
        else
          puts "number before and after outlier have distance greater than 3"
          eliminated_count += 1
        end
        break
      else
        puts "else I forgott something"
      end
    else
      puts "some error I didn't think of"
    end
  end
end
file.close
puts "possible errors"
puts errors
puts "success_count"
puts success_count
puts "eliminated_count"
puts eliminated_count
puts "sum"
puts success_count + eliminated_count
puts "result"
puts result.count
