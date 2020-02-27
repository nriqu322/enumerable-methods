module Enumerable
  def my_each
    # iterate trough an object, takes one parameter
    return to_enum :my_each unless block_given?
    i = 0
    while i < length
      yield(self[i])
      i += 1
    end
  end

  def my_each_with_index
    # iterate trough an object value and index, takes two parameters
    return to_enum :my_each_with_index unless block_given?
      idx = 0
      while idx < length
        yield(self[idx], idx)
        idx += 1
      end
  end

  def my_select
    #filters values given a condition
    return to_enum :my_select unless block_given?
    new_array = []
    self.my_each { |x| new_array.push(x) if yield(x) }
    new_array
  end

  def my_all?(param = nil)
    #evaluates all elements in array and return true if all of them meets the given condition
    if block_given?
      all_true = true
      self.my_each { |x| all_true = false if !yield(x)}
    elsif self.nil?
      return false
    elsif param
      self.my_each { }
    else
      return true
    end
    all_true
  end

  def my_any?
    #evaluates all elements in array and return true if any of them meets the given condition
    if block_given?
      any_true = false
      self.my_each { |x| any_true = true if yield(x) }
    else 
      any_true = true unless nil
    end
    any_true
  end

  #def my_none?
    ##evaluates all elements in array and return true if all of them are false
  #  if block_given?
  #    all_false = true
  #    self.my_each { |x| all_false = false if yield(x) }
  #  else
  #    all_false = true
  #  end
  #  all_false
  end
end

%w[ant bear cat].my_all? { |word| word.length >= 3 } #=> true
%w[ant bear cat].my_all? { |word| word.length >= 4 } #=> false
[1, 2, 3.14].my_all?(Numeric)                       #=> true
[nil, true, true].my_all?                              #=> false
[].my_all?                                           #=> true

#array = %w[5 2 7 4 1]

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

#array_two = %w[house car bottle cloud candle]
#array_three = %w[1, 1, 1, 1]

#test my_all?
#array_two.all? { |x| x.length <= 6 }
#puts
#array_two.my_all? { |x| x.length <= 6 }
#puts

#test my_any?
#array_three.any? #{ |x| x.length <= 6 }
#puts
#array_three.my_any? #{ |x| x.length <= 6 }
#puts



#%w[ant bear cat].my_any? { |word| word.length >= 3 } #=> true
#%w[ant bear cat].my_any? { |word| word.length >= 4 } #=> true
#[nil, true, 99].my_any?(Integer)                     #=> true
#[nil, true, 99].my_any?                              #=> true
#[].any?                                              #=> false

#%w{ant bear cat}.my_none? { |word| word.length == 5 } #=> true
#%w{ant bear cat}.my_none? { |word| word.length >= 4 } #=> false
#%w{ant bear cat}.my_none?(/d/)                        #=> true
#[1, 3.14, 42].my_none?(Float)                         #=> false
#[].my_none?                                           #=> true
#[nil].my_none?                                        #=> true
#[nil, false].my_none?                                 #=> true
#[nil, false, true].my_none?                           #=> false