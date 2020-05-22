module Enumerable
    def my_each
      array = to_a
      i = 0
      while i < size
        return array.to_enum unless block_given?
  
        yield(array[i])
        i += 1
      end
      self
    end
  
    
  end