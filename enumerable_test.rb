require_relative 'enumerable_methods.rb'

class Array
  prepend Enumerable
end

# my_each
puts 'Test for #my_each'
%w[Sally Marchony Bill].my_each { |x| print x, ' -- ' }
puts


# my_each_with_index
puts 'Test for #my_each_with_index'
hash = {}
%w[Jean dog Etienne].my_each_with_index { |item, index| hash[item] = index }
print hash
puts
(1..5).my_each_with_index { |item, index| puts "#{item} => #{index}" }
puts
[1, 2, 3, 4, 5].my_each_with_index { |item, index| puts "#{item} => #{index}" }
puts


# my_select
puts 'Test for #my_select'
print([2, 1, 6, 7, 4, 8, 10].my_select(&:even?))
puts


# my_all
puts 'Test for #my_all'
puts(%w[Marc Luc Jean].my_all? { |word| word.length >= 3 })
puts(%w[Marc Luc Jean].my_all? { |word| word.length >= 4 })
puts [2, 1, 6, 7, 4, 8, 10].my_all?(3)
puts %w[Marc Luc Jean].my_all?('Jean')
puts %w[Marc Luc Jean].my_all?(/a/)
puts [1, 5i, 5.67].my_all?(Numeric)
puts [2, 1, 6, 7, 4, 8, 10].my_all?(Integer)
puts [nil, true, 99].my_all?
puts [nil, false].my_all?
puts [nil, nil, nil].my_all?
puts [].my_all?


# my_any
puts 'Test for #my_any'
puts(%w[Marc Luc Jean].my_any? { |word| word.length >= 3 })
puts(%w[Marc Luc Jean].my_any? { |word| word.length >= 4 })
puts %w[Marc Luc Jean].my_any?(/d/)
puts [2, 1, 6, 7, 4, 8, 10].my_any?(7)
puts %w[Marc Luc Jean].my_any?('Jean')
puts [nil, true, 99].my_any?(Integer)
puts ['1', 5i, 5.67].my_any?(Numeric)
puts [nil, true, 99].my_any?
puts [nil, false].my_any?
puts [nil, nil, nil].my_any?
puts [].my_any?


# my_none
puts 'Test for #my_none'
puts(%w[Marc Luc Jean].my_none? { |word| word.length == 5 })
puts(%w[Marc Luc Jean].my_none? { |word| word.length >= 4 })
puts %w[Marc Luc Jean].my_none?(/j/)
puts [2, 1, 6, 7, 4, 8, 10].my_none?(15)
puts %w[Marc Luc Jean].my_none?('Jean')
puts [1, 3.14, 42].my_none?(Float)
puts [1, 5i, 5.67].my_none?(Numeric)
puts [].my_none?
puts [nil].my_none?
puts [nil, false].my_none?
puts [nil, false, true].my_none?
puts [nil, nil, nil, nil].my_none?


# my_count
puts 'Test for #my_count'
puts [1, 2, 4, 2].my_count
puts [1, 2, 4, 2].my_count(2)
puts([1, 2, 4, 2].my_count { |x| x > 1 })


