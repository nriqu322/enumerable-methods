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
    # filters values given a condition
    return to_enum :my_select unless block_given?
    new_array = []
    my_each { |x| new_array.push(x) if yield(x) }
    new_array
  end

  def my_all?(param = nil)
    # evaluates all elements in array and return true if all of them meets the given condition
    return test_param_all(param) unless param.nil?
    all_true = true
    if block_given?
      my_each { |x| all_true = false unless yield(x)}
    else
      my_each { |x| all_true = false if x.nil? || x == false }
    end
    all_true
  end

  def test_param_all(param)
    if param.class == Regexp
      my_all? { |x| x =~ param}
    elsif param.class == Class
      my_all? { |x| x.is_a? param}
    else
      my_all? { |x| x == param}
    end
  end

  def my_any?(param = nil)
    # evaluates all elements in array and return true if any of them meets the given condition
    return test_param_any(param) unless param.nil?
    any_true = false
    if block_given?
      my_each { |x| any_true = true if yield(x) }
    else 
      my_each { |x| any_true = true if !x.nil? && x != false }
    end
    any_true
  end

  def test_param_any(param)
    if param.class == Regexp
      my_any? { |x| x =~ param}
    elsif param.class == Class
      my_any? { |x| x.is_a? param}
    else
      my_any? { |x| x == param}
    end
  end

  # def my_none?
    # evaluates all elements in array and return true if all of them are false
  #  if block_given?
  #    all_false = true
  #    self.my_each { |x| all_false = false if yield(x) }
  #  else
  #    all_false = true
  #  end
  #  all_false
  # end
end


%w[ant bear cat].my_any? { |word| word.length >= 3 } #=> true
%w[ant bear cat].my_any? { |word| word.length >= 4 } #=> true
[nil, true, 99].my_any?(Integer)                     #=> true
[nil, true, 99].my_any?                              #=> true
[].any?                                              #=> false

# %w{ant bear cat}.my_none? { |word| word.length == 5 } #=> true
# %w{ant bear cat}.my_none? { |word| word.length >= 4 } #=> false
# %w{ant bear cat}.my_none?(/d/)                        #=> true
# [1, 3.14, 42].my_none?(Float)                         #=> false
# [].my_none?                                           #=> true
# [nil].my_none?                                        #=> true
# [nil, false].my_none?                                 #=> true
# [nil, false, true].my_none?                           #=> false