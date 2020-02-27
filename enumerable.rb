module Enumerable
  def my_each
    # iterate trough an object
    i = 0
    while i < length
      yield(self[i])
      i += 1
    end
  end

  def my_each_with_index
    # iterate trough an object
    idx = 0
    while idx < length
      yield(self[idx], idx)
      idx += 1
    end
  end
end

# test my_each
# array = %w[5 2 7 4 1]
# array.each { |x| puts x.to_i * 2 }
# puts
# array.my_each { |x| puts x.to_i * 2 }

# test my_each_with_index
# array.each_with_index { |val, idx| puts "value #{val} : idx #{idx}" }
# puts
# array.my_each_with_index { |val, idx| puts "value #{val} : idx #{idx}" }
# puts
