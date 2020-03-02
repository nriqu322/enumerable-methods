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
      my_each { |x| all_true = false unless yield(x) }
    else
      my_each { |x| all_true = false if x.nil? || x == false }
    end
    all_true
  end

  def test_param_all(param)
    if param.class == Regexp
      my_all? { |x| x =~ param }
    elsif param.class == Class
      my_all? { |x| x.is_a? param }
    else
      my_all? { |x| x == param }
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
      my_any? { |x| x =~ param }
    elsif param.class == Class
      my_any? { |x| x.is_a? param }
    else
      my_any? { |x| x == param }
    end
  end

  def my_none?(param = nil)
    # evaluates all elements in array and return true if all of them are false
    return test_param_none(param) unless param.nil?
    all_false = true
    if block_given?
      my_each { |x| all_false = false if yield(x) }
    else
      my_each { |x| all_false = false unless x.nil? || x == false }
    end
    all_false
  end

  def test_param_none(param)
    if param.class == Regexp
      my_none? { |x| x =~ param }
    elsif param.class == Class
      my_none? { |x| x.is_a? param }
    else
      my_none? { |x| x == param }
    end
  end

  def my_count(param = nil)
    # count the number of items that meets the condition given
    total = 0
    if block_given?
      my_each { |x| total += 1 if yield(x) }
    elsif !param.nil?
      my_each { |x| total += 1 if x == param }
    else
      return length
    end
    total
  end
end

ary = [1, 2, 4, 2]
ary.my_count               #=> 4
ary.my_count(2)            #=> 2
ary.my_count{ |x| x%2==0 } #=> 3