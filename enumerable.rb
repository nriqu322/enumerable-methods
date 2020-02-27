module Enumerable
  def my_each
    # iterate trough an object, takes one parameter
    return to_enum unless block_given?
    i = 0
    while i < length
      yield(self[i])
      i += 1
    end
  end

  def my_each_with_index
    # iterate trough an object value and index, takes two parameters
    return to_enum unless block_given?
      idx = 0
      while idx < length
        yield(self[idx], idx)
        idx += 1
      end
  end

  def my_select
    #filters values given a condition
    return to_enum unless block_given?
    new_array = []
    self.my_each { |x| new_array.push(x) if yield(x) }
    new_array
  end

  def my_all?
    #evaluates all elements in array and return true if all of them meets the given condition
    return to_enum unless block_given?
    result = true
    self.my_each { |x| result = false if !yield(x)}
    result
  end
end

array = %w[5 2 7 4 1]

#test my_each
#array.each { |x| puts x.to_i * 2 }
#puts
#array.my_each { |x| puts x.to_i * 2 }
#puts

#test my_each_with_index
#array.each_with_index { |val, idx| puts "value #{val} : idx #{idx}" }
#puts
#array.my_each_with_index { |val, idx| puts "value #{val} : idx #{idx}" }
#puts

#test my_select
#array.select { |x| puts x if x.to_i < 5 }
#puts
#array.my_select { |x| puts x if x.to_i < 5 }
#puts

array_two = %w[house car bottle cloud candle]

#test my_all?
array_two.all? { |x| x.length <= 6 }
puts
array_two.my_all? { |x| x.length <= 6 }
#puts