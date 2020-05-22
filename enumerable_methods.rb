module Enumerable
  def my_each
    array = to_a
    n = 0
    while n < array.length
      return array.to_enum unless block_given?

      yield(array[n])
      n += 1
    end
    self
  end

  def my_each_with_index
    return to_enum unless block_given?

    array = to_a

    (0...array.length).my_each { |n| yield(array[n], n) }

    self
  end
  

  def my_select
     array = []
    n = 0
    while n < size
      return to_enum unless block_given?

       array << self[n] if yield(self[n])
      n += 1
    end
     array
  end


  def my_all?(array = nil)
    if block_given?
      my_each { |e| return false unless yield(e) }
      true
    elsif array
      if array.is_a? Regexp
        my_each { |e| return false unless e =~ array }
      elsif array.is_a? Class
        my_each { |e| return false unless e.is_a? array }
      else
        my_each { |e| return false unless e == array }
      end
    else
      my_each { |e| return false unless e }
    end
    true
  end

  def my_any?(array = nil)
    if !block_given? && array.nil?
      my_each do |n|
        return true if n != false && !n.nil?
      end
      return false
    end

    if array.is_a?(Regexp)
      my_each do |n|
        return true if n =~ array
      end
    elsif array.is_a?(Class)
      my_each do |n|
        return true if n.is_a? array
      end
    elsif block_given?
      my_each do |n|
        return true if yield(n)
      end
    else
      my_each do |n|
        return true if n == array
      end
    end
    false
  end

  def my_none?(array = nil)
    if block_given?
      my_each { |e| return false if yield(e) }
      true
    elsif array
      if array.is_a? Regexp
        my_each { |e| return false if e =~ array }
      elsif array.is_a? Class
        my_each { |e| return false if e.is_a? array }
      else
        my_each { |e| return false if e == array }
      end
    else
      my_each { |e| return false if e }
    end
    true
  end


   def my_count(array = nil)
    return length unless !array.nil? || block_given?

    count = 0
    if !block_given?
      my_each do |n|
        count += 1 if n == array
      end
    else
      my_each do |n|
        count += 1 if yield(n)
      end
    end
    count
  end

  # def my_map(&proc)
  #   return to_enum unless block_given?

  #   array = to_a
  #   arr = []
  #   n = 0

  #   while n < array.size
  #     arr << proc.call(array[n])
  #     n += 1
  #   end
  #   arr
  # end

  def my_map(proc = nil)
    return to_enum(:my_map) if !block_given? && proc.nil?

    map_items = []

    if !proc.nil?
      my_each_with_index do |n, i|
        map_items [i] = proc.call(n)
      end
    else
      my_each_with_index do |n, i|
        map_items [i] = yield n
      end
    end
    map_items
  end

  def my_inject(*array)
    arr = to_a.dup
    if array[0].nil?
      elements = arr.shift
    elsif array[1].nil? && !block_given?
      symbol = array[0]
      elements = arr.shift
    elsif array[1].nil? && block_given?
      elements = array[0]
    else
      elements = array[0]
      symbol = array[1]
    end
    arr[0..-1].my_each do |n|
      elements = if symbol
                 elements.send(symbol, n)
               else
                 yield(elements, n)
               end
    end
    elements
  end

  def multiply_els(arr)
  arr.my_inject(1) { |element, n| element * n }
end
end